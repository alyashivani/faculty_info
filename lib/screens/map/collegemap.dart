import 'package:faculty_info/screens/map/LTbuilding.dart';
import 'package:faculty_info/shared/constants.dart';
import 'package:faculty_info/screens/map/ATCbuilding.dart';

import 'package:flutter/material.dart';
import 'package:faculty_info/shared/inkwelldrawer.dart';

class CollegeMap extends StatefulWidget {
  final Function toggleView;
  CollegeMap({this.toggleView});

  @override
  _CollegeMapState createState() => _CollegeMapState();
}

class _CollegeMapState extends State<CollegeMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: InkWellDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          elevation: 0.0,
          title: Text('College Map'),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ATCbuilding();
                      }));
                    },
                    style: mapButtonStyle,
                    child: Text(
                      'ATC Building',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LTbuilding();
                      }));
                    },
                    style: mapButtonStyle,
                    child: Text(
                      'LT Building',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {},
                    style: mapButtonStyle,
                    child: Text(
                      'CS Department',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {},
                    style: mapButtonStyle,
                    child: Text(
                      'Civil Department',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  )
                ])));
  }
}
