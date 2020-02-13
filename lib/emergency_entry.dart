import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'location.dart';

class EmergencyEntry extends StatefulWidget {
  @override
  _EmergencyEntryState createState() => _EmergencyEntryState();
}

class _EmergencyEntryState extends State<EmergencyEntry> {
  String dropdownValue = 'Fire';
  final mainReference = FirebaseDatabase.instance.reference();
  TextEditingController eController = TextEditingController();
  Position position;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Fire', 'Motor Accident', 'Robbery', 'Health Emergency', 'Other']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }
                ).toList(),
              ),
              Center(
                child: TextField(
                  controller: eController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      border: OutlineInputBorder(),
                      labelText: 'Enter The Specifics Of Your Emergency'
                  ),
                ),
              ),
              FlatButton(
                child: Text('Send Distress Signal'),
                onPressed: () {
                  sendEmergency();
                },
              ),
              FlatButton(
                child: Text('Get Location Object'),
                onPressed: ()=>  _getCurrentLocation(),
              )
            ],
          )
      ),
    );
  }
  void sendEmergency() {
    mainReference.push().set(DistressCall(description: eController.text, latitude: position.latitude, longitude: position.longitude, type: dropdownValue).toJson());
  //  mainReference.child('1').set({
   //   'id': 'ID1',
    //  'data': 'Sample data'
   // });
    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Distress Signal Sent')));
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    debugPrint(res.toString());
    setState(() {
      position = res;
    });
    debugPrint(position.latitude.toString());
  }
}

//08162214241