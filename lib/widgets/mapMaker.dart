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

//   static final CameraPosition _kGooglePlex = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 14.4746,
//   );

//   static final CameraPosition _kLake = CameraPosition(
//       bearing: 192.8334901395799,
//       target: LatLng(37.43296265331129, -122.08832357078792),
//       tilt: 59.440717697143555,
//       zoom: 19.151926040649414);

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(children: [
      GoogleMap(
        mapType: MapType.normal, // Todo create Map_selection Option
        initialCameraPosition:
            CameraPosition(target: LatLng(40.712776, -74.005974)),

        onMapCreated: _onMapCreated,
        myLocationEnabled: true,

        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        //},

        markers: {
          crimeType1Marker,
          crimeType2Marker,
          crimeType3Marker,
          crimeType4Marker,
        },

        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: _goToTheLake,
        //   label: Text('To the lake!'),
        //   icon: Icon(Icons.directions_boat),
      ),
      _zoomMinusFunction(),
      _zoomPlusFunction(),
      _buildContainer(),
      Positioned(
        bottom: 50,
        left: 10,
        child: FlatButton(
            child: Icon(
              Icons.pin_drop,
              color: Colors.white,
            ),
            color: Colors.green,
            onPressed: () {}
            //_addMarker,
            ),
      )
    ]));
  }

  Widget _zoomMinusFunction() {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
          icon: Icon(Icons.zoom_out),
          onPressed: () {
            zoomVal--;
            _minus(zoomVal);
          }),
    );
  }

  Widget _zoomPlusFunction() {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          icon: Icon(Icons.zoom_in),
          onPressed: () {
            zoomVal++;
            _minus(zoomVal);
          }),
    );
  }

  Future<void> _minus(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(40.712776, 74.005974), zoom: zoomVal)));
  }

  Widget _buildContainer() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                "image",
                40.738300,
                -73.988426,
                "Crime Type 1",
              ),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                "image",
                40.742740,
                -74.003510,
                "Crime Type 2",
              ),
            ),
            SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _boxes(
                "image2",
                40.738300,
                -73.988426,
                "Crime Type 3",
              ),
            )
          ],
        ),
      ),
    );
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
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
  Marker crimeType3Marker = Marker(
    markerId: MarkerId('crimeType3'), //todo better deifene crimeTypes
    position: LatLng(40.742740, -74.003510),
    infoWindow: InfoWindow(title: 'Crime Type3'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueCyan,
    ),
  );
  Marker crimeType4Marker = Marker(
    markerId: MarkerId('crimeType4'), //todo better deifene crimeTypes
    position: LatLng(40.742530, -73.983510),
    infoWindow: InfoWindow(title: 'Crime Type4'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueGreen,
    ),
  );

// _addMarker(){
//   var _addmarker = Marker(
//     position: mapCon )
// }

  Widget _boxes(
      String _image, double lat, double long, String crimeTypeDescription) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
        print('GotoLocation selected');
      },
      child: Container(
        child: new FittedBox(
            child: Material(
          color: Colors.white,
          elevation: 14.0,
          borderRadius: BorderRadius.circular(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100,
                height: 200,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(24.0),
                  child: Text(_image),
                ),
              ),
              Container(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: crimeDetailsContainer(crimeTypeDescription)),
              )
            ],
          ),
        )),
      ),
    );
  }

  Widget crimeDetailsContainer(String crimeTypeDescription) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            child: Text(
              crimeTypeDescription,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
