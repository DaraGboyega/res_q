import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  GoogleMapController _controller;
  Position position;
  Widget _child;

  @override
  void initState() {
    _child= CircularProgressIndicator();
    getCurrentLocation();
    super.initState();
  }

  void getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    debugPrint(res.toString());
    setState(() {
      position = res;
      _child = mapWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[700]
      ),
      home: Scaffold(
        body: _child,
      ),
    );
  }

  Widget mapWidget() {
    Set<Marker> _createMarker() {
      return <Marker>[
        Marker(
            markerId: MarkerId("Your Location"),
            position: LatLng(position.latitude, position.longitude),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: "Your Location")
        )
      ].toSet();
    }
    return GoogleMap(
      markers: _createMarker(),
      mapType: MapType.normal,
      onMapCreated: (GoogleMapController controller) {
        _controller = controller;
      } ,
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16,
      ),
    );
  }
}