import 'package:flutter/material.dart';
import 'package:res_q/emergencies.dart';
import 'package:res_q/hotline.dart';
import 'emergency_entry.dart';
import 'landing.dart';

void main() => runApp(Helper());

class Helper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[700],
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('ResQ'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(icon: Icon(Icons.my_location),
                    text: 'My Location'),
                Tab(icon: Icon(Icons.add_alert),
                    text: 'Send Distress Signal'),
                Tab(icon: Icon(Icons.location_searching),
                text: 'Emergencies',),
                Tab(icon: Icon(Icons.phone),
                text: 'Hotlines',)
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              MyApp(), EmergencyEntry(), Emergencies(), Hotline()
            ],
          ),
        ),
      ),
    );
  }
}