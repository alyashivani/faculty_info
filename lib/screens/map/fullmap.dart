import 'package:flutter/cupertino.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';

import 'package:faculty_info/shared/inkwelldrawer.dart';

class FullMap extends StatefulWidget {
  FullMap({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _FullMapState createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {
  Object mapview;

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
        title: Text('Map'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.amber],
        )),
        child: PhotoView(
          imageProvider: AssetImage("images/map.png"),
          backgroundDecoration: mapview,
          enableRotation: false,
        ),
      ),
    );
  }
}
