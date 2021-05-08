import 'package:flutter/material.dart';
import 'package:faculty_info/shared/inkwelldrawer.dart';
import 'package:faculty_info/shared/constants.dart';
import 'package:faculty_info/screens/home/Faculty_Info_List.dart';

class DashBoard extends StatefulWidget {
  final Function toggleView;
  DashBoard({this.toggleView});

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Faculty Information")),
        drawer: InkWellDrawer(),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FacultyInfoList(dept: "Information Technology");
                      }));
                    },
                    style: mapButtonStyle,
                    child: Text(
                      'Information Technology',
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
                        return FacultyInfoList(dept: "Industrial & Production");
                      }));
                    },
                    style: mapButtonStyle,
                    child: Text(
                      'Industrial & Production',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FacultyInfoList(dept: "Mechanical Department");
                      }));
                    },
                    style: mapButtonStyle,
                    child: Text(
                      'Mechanical Department',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FacultyInfoList(dept: "CS Department");
                      }));
                    },
                    style: mapButtonStyle,
                    child: Text(
                      'CS Department',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FacultyInfoList(dept: "Civil Department");
                      }));
                    },
                    style: mapButtonStyle,
                    child: Text(
                      'Civil Department',
                      style: TextStyle(color: Colors.grey[850]),
                    ),
                  )
                ])));
  }
}
