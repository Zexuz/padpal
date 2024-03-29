import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pad_pal/bloc/event_filter/event_filter_cubit.dart';
import 'package:pad_pal/components/app_bar/app_bar.dart';
import 'package:pad_pal/theme.dart';

import '../../../../components/input/google_search_input.dart';

class EventFilterPage extends StatelessWidget {
  static Route<void> route(BuildContext context) {
    return MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: context.bloc<EventFilterCubit>(),
        child: const EventFilterPage(),
      ),
    );
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

class MapSample extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Settings",
      ),
      body: BlocListener<EventFilterCubit, EventFilterState>(
        listenWhen: (previous, current) => previous.location != current.location,
        listener: (context, state) async {
          final controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(state.location.lat, state.location.lng),
            zoom: 14.0,
          )));
        },
        child: BlocBuilder<EventFilterCubit, EventFilterState>(
          builder: (context, state) {
            if (state == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                  child: GoogleSearchInput(
                    initialValue: state.location?.description,
                    decoration: AppTheme.graySearch.copyWith(
                      hintText: "Search by town/city, area or postcode",
                    ),
                    onChanged: (lat, lng, name) => context.bloc<EventFilterCubit>().onLocationChanged(lat, lng, name),
                  ),
                ),
                Expanded(
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(state.location.lat, state.location.lng),
                      zoom: 13.0,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      if (!_controller.isCompleted) _controller.complete(controller);
                      _setCameraToMyLocation();
                    },
                  ),
                ),
                _Distance(),
                _Timespan(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Distance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFilterCubit, EventFilterState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Distance"),
                Text("${state.distance} km"),
              ],
            ),
            Slider(
              value: state.distance.toDouble(),
              min: 1,
              max: 100,
              divisions: 100,
              label: "${state.distance.round()} km",
              onChanged: (value) => context.bloc<EventFilterCubit>().onDistanceChanged(value.round()),
              // onChanged: (double value) {
              //   setState(() {
              //     print(position);
              //     if (position != null) {
              //       print(position);
              //       _circles.add(Circle(
              //         circleId: CircleId("1"),
              //         center: position,
              //         fillColor: AppTheme.secondaryColorOrange.withOpacity(0.12),
              //         strokeColor: AppTheme.secondaryColorOrange,
              //         strokeWidth: 1,
              //         radius: value,
              //       ));
              //     }
              //     _currentSliderValue = value;
              //   });
              // },
            )
          ],
        );
      },
    );
  }
}

class _Timespan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventFilterCubit, EventFilterState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Timespan"),
                Text("${state.timeSpan.start.round()}-${state.timeSpan.end.round()} days"),
              ],
            ),
            RangeSlider(
              values: state.timeSpan,
              min: 0,
              max: 14,
              divisions: 14,
              labels: RangeLabels(state.timeSpan.start.round().toString(), state.timeSpan.end.round().toString()),
              onChanged: (values) => context.bloc<EventFilterCubit>().onTimeSpanChanged(values),
            )
          ],
        );
      },
    );
  }
}
