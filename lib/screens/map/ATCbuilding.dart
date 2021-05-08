import 'package:faculty_info/shared/constants.dart';

import 'package:flutter/material.dart';
import 'package:faculty_info/shared/inkwelldrawer.dart';

class ATCbuilding extends StatefulWidget {
  final Function toggleView;
  ATCbuilding({this.toggleView});

  @override
  _ATCbuildingState createState() => _ATCbuildingState();
}

class _ATCbuildingState extends State<ATCbuilding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: InkWellDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.amber,
          elevation: 0.0,
          title: Text('ATC Building'),
        ),
        body: Container(
            child: Column(
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              ElevatedButton(
                onPressed: () async {},
                style: tabButtonStyle,
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              SizedBox(width: 5.0),
              ElevatedButton(
                onPressed: () async {},
                style: tabButtonStyle,
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              SizedBox(width: 5.0),
              ElevatedButton(
                onPressed: () async {},
                style: tabButtonStyle,
                child: Text(
                  '2',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              SizedBox(width: 5.0),
              ElevatedButton(
                onPressed: () async {},
                style: tabButtonStyle,
                child: Text(
                  '3',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              SizedBox(width: 5.0),
              ElevatedButton(
                onPressed: () async {},
                style: tabButtonStyle,
                child: Text(
                  '4',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
            ])));
  }
}
