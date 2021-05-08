import 'package:faculty_info/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:faculty_info/shared/inkwelldrawer.dart';

class LTbuilding extends StatefulWidget {
  final VoidCallback onPressed;
  final String imageData;
  final String buttonName;
  LTbuilding({this.onPressed, this.imageData, this.buttonName});

  @override
  _LTbuildingState createState() => _LTbuildingState();
}

class _LTbuildingState extends State<LTbuilding> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  VoidCallback _showPersBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showPersBottomSheetCallBack = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _showPersBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
          return new Container(
            height: 700.0,
            color: Colors.amber,
          );
        })
        .closed
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _showPersBottomSheetCallBack = _showBottomSheet;
            });
          }
        });
  }

  void _showModalSheet(int i) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          if (i == 0) {
            return new Container(
              color: Colors.amber,
              child: new Image(
                image: AssetImage('images/LT1.png'),
              ),
            );
          } else if (i == 1) {
            return new Container(
              color: Colors.amber,
              child: new Image(
                image: AssetImage('images/LT2.png'),
              ),
            );
          } else {
            return new Container(
              color: Colors.amber,
              child: new Image(
                image: AssetImage('images/LT1.png'),
              ),
            );
          }
        });
  }

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
          title: Text('LT Building'),
        ),
        body: Container(
            child: Column(
                verticalDirection: VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
              SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () {
                  _showModalSheet(0);
                },
                style: tabButtonStyle,
                child: Text(
                  '0',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () {
                  _showModalSheet(1);
                },
                style: tabButtonStyle,
                child: Text(
                  '1',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () {
                  _showModalSheet(2);
                },
                style: tabButtonStyle,
                child: Text(
                  '2',
                  style: TextStyle(color: Colors.grey[850]),
                ),
              ),
              SizedBox(height: 5.0),
              Container(
                child: new DecoratedBox(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("images/LT1.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ])));
  }
}
