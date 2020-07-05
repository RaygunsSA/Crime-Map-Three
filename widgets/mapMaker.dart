import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Google Maps Demo',
//       home: MapSample(),
//     );
//   }
// }

class MapMaker extends StatefulWidget {
  @override
  State<MapMaker> createState() => MapSampleState();
}

class MapSampleState extends State<MapMaker> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal, // Todo create Map_selection Option
        initialCameraPosition:
            CameraPosition(target: LatLng(40.712776, -74.005974)),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {
          crimeType1Marker,
          crimeType2Marker,
        },

        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
      ),
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}

Marker crimeType1Marker = Marker(
  markerId: MarkerId('crimeType1'), //todo better deifene crimeTypes
  position: LatLng(40.742451, -74.005959),
  infoWindow: InfoWindow(title: 'Crime Type'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueRed,
  ),
);

Marker crimeType2Marker = Marker(
  markerId: MarkerId('crimeType2'), //todo better deifene crimeTypes
  position: LatLng(40.742640, -73.983510),
  infoWindow: InfoWindow(title: 'Crime Type2'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueBlue,
  ),
);
