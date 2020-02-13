import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:res_q/location.dart';

class Emergencies extends StatefulWidget {
  @override
  _EmergenciesState createState() => _EmergenciesState();
}

class _EmergenciesState extends State<Emergencies> {
  final mainReference = FirebaseDatabase.instance.reference();
  DistressCall retrievedLoc;
  Widget _child;
  GoogleMapController _controller;

  @override
  void initState(){
    _child = CircularProgressIndicator();
    retrievePos();
    super.initState();
  }

  void retrievePos() {
    setState(() {
      _child = streamWidget();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _child,
    );
  }

  Widget streamWidget() {
    return StreamBuilder(
      stream: mainReference.onValue,
      builder: (context, snap) {
        if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {
          Map data = snap.data.snapshot.value;
          List item = [];

          data.forEach((index, data) => item.add({"key": index, ...data}));

          return ListView.builder(
            itemCount: item.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(item[index]['type']),
                trailing: Text(item[index]['description']),
                onTap: ()=> {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => EmergencyMap(mapLoc: EmergencyMapLoc(item[index]['latitude'], item[index]['longitude']))
                  ))
                },
              );
            }
          );
        }
        else return Text("No Data");
      }
    );
  }
}

class EmergencyMapLoc {
  final double latitude;
  final double longitude;

  EmergencyMapLoc(this.latitude, this.longitude);
}

class EmergencyMap extends StatelessWidget {
  final EmergencyMapLoc mapLoc;

  EmergencyMap({Key key, @required this.mapLoc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    GoogleMapController _controller;
    return MaterialApp(
      home: Scaffold(
        body: GoogleMap(
          markers: <Marker>[
            Marker(
                markerId: MarkerId("Emergency!!!"),
                position: LatLng(mapLoc.latitude, mapLoc.longitude),
                icon: BitmapDescriptor.defaultMarker,
                infoWindow: InfoWindow(title: "Emergency!!!")
            )
          ].toSet(),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          } ,
          initialCameraPosition: CameraPosition(
            target: LatLng(mapLoc.latitude, mapLoc.longitude),
            zoom: 16,
          ),
        ),
      ),
    );
  }
}


