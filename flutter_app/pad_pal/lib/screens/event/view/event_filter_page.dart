import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/theme.dart';

class EventFilterPage extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const EventFilterPage());
  }

  const EventFilterPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MapSample(),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  Set<Circle> _circles = Set();

  double _currentSliderValue = 10.0;
  RangeValues _currentRangeValues = RangeValues(1, 3);

  LatLng position;

  static final CameraPosition _swedenCameraPosistion = CameraPosition(
    target: LatLng(58.21, 14.53),
    zoom: 3.0,
  );

  Future<void> _setCameraToMyLocation() async {
    const myZoom = 14.0;
    final position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    await _setCameraPosition(LatLng(position.latitude, position.longitude), myZoom);
  }

  Future<void> _setCameraPosition(LatLng latLng, double zoom) async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: latLng,
      zoom: zoom,
    )));
  }

  Future<void> _updateMapPositionWithCurrentLocation() async {
    // print("asdkjasd");
    // final pos = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // setState(() {
    //   print("robin $pos");
    //   position = LatLng(pos.latitude, pos.longitude);
    //   print(position);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Search by town/city, area or postcode',
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              circles: _circles,
              initialCameraPosition: _swedenCameraPosistion,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _updateMapPositionWithCurrentLocation();
                _setCameraToMyLocation();
              },
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Distance"),
                  Text("${_currentSliderValue.round()} km"),
                ],
              ),
              Slider(
                value: _currentSliderValue,
                min: 1,
                max: 100,
                divisions: 100,
                label: "${_currentSliderValue.round()} km",
                onChanged: (double value) {
                  setState(() {
                    print(position);
                    if(position != null){
                      print(position);
                      _circles.add(Circle(
                        circleId: CircleId("1"),
                        center: position,
                        fillColor: AppTheme.secondaryColorOrange.withOpacity(0.12),
                        strokeColor: AppTheme.secondaryColorOrange,
                        strokeWidth: 1,
                        radius: value,
                      ));
                    }
                    _currentSliderValue = value;
                  });
                },
              )
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Timespan"),
                  Text("${_currentRangeValues.start.round()}-${_currentRangeValues.end.round()} days"),
                ],
              ),
              RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 14,
                divisions: 14,
                labels: RangeLabels(
                    _currentRangeValues.start.round().toString(), _currentRangeValues.end.round().toString()),
                onChanged: (value) {
                  setState(() {
                    _currentRangeValues = value;
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
