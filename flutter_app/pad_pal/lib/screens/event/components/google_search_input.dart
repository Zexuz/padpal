import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "AIzaSyDgALxXX0-oI52s_iCxywB03lhjenKfiXg";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

typedef LocationSelected = Function(double lat, double lng, String name);

class GoogleSearchInput extends StatefulWidget {
  GoogleSearchInput({
    Key key,
    @required this.onChanged,
    this.initialValue,
    FocusNode focus,
    this.decoration,
  })  : this.focus = focus ?? FocusNode(),
        super(key: key);

  final LocationSelected onChanged;
  final String initialValue;
  final FocusNode focus;
  final InputDecoration decoration;

  @override
  _GoogleSearchInputState createState() => _GoogleSearchInputState();
}

class _GoogleSearchInputState extends State<GoogleSearchInput> {
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      focusNode: widget.focus,
      onTap: () => _handlePressButton(context),
      controller: _controller,
      decoration: widget.decoration,
    );
  }

  Future<void> _handlePressButton(BuildContext context) async {
    final p = await PlacesAutocomplete.show(
      logo: Container(height: 0),
      context: context,
      apiKey: kGoogleApiKey,
      onError: (value) => Scaffold.of(context).showSnackBar(SnackBar(content: Text(value.errorMessage))),
      mode: Mode.overlay,
      language: "se",
      components: [Component(Component.country, "se")],
    );

    if (p == null) return;

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    _controller.text = p.description;
    widget.onChanged(lat, lng, p.description);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
