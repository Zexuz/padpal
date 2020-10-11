import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:pad_pal/bloc/event_filter/event_filter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const kGoogleApiKey = "AIzaSyDgALxXX0-oI52s_iCxywB03lhjenKfiXg";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class GoogleSearchInput extends StatefulWidget {
  const GoogleSearchInput({
    Key key,
  }) : super(key: key);

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
    return BlocBuilder<EventFilterCubit, EventFilterState>(
      buildWhen: (previous, current) => previous.location != current.location,
      builder: (context, state) {
        _controller.text = state.location?.description;
        return TextFormField(
          controller: _controller,
          decoration: InputDecoration.collapsed(hintText: "Search by town/city, area or postcode"),
          focusNode: _focus,
        );
      },
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

    context.bloc<EventFilterCubit>().onLocationChanged(lat, lng, p.description);
  }
}
