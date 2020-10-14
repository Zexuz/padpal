import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

const kGoogleApiKey = "AIzaSyDgALxXX0-oI52s_iCxywB03lhjenKfiXg";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

typedef LocationSelected = Function(double lat, double lng, String name);

class GoogleSearchInput extends StatefulWidget {
  const GoogleSearchInput({
    Key key,
    @required this.onLocationSelected,
    this.initValue,
  }) : super(key: key);

  final LocationSelected onLocationSelected;
  final String initValue;

  @override
  _GoogleSearchInputState createState() => _GoogleSearchInputState();
}

class _GoogleSearchInputState extends State<GoogleSearchInput> {
  FocusNode _focus = new FocusNode();

  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    _controller.text = widget.initValue;
  }

  void _onFocusChange() {
    if (_focus.hasFocus) {
      _handlePressButton(context);
      _focus.unfocus();
    }
    debugPrint("Focus: " + _focus.hasFocus.toString());
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration.collapsed(hintText: "Search by town/city, area or postcode"),
      focusNode: _focus,
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
    widget.onLocationSelected(lat, lng, p.description);
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
