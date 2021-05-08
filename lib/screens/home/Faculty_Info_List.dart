import 'package:faculty_info/screens/home/showdetail.dart';
import 'package:faculty_info/shared/loading.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FacultyInfoList extends StatefulWidget {
  FacultyInfoList({Key key, @required this.dept}) : super(key: key);

  final String dept;

  @override
  _FacultyInfoListState createState() => _FacultyInfoListState(dept);
}

class _FacultyInfoListState extends State<FacultyInfoList> {
  String dept;
  _FacultyInfoListState(this.dept);
  final _firestore = FirebaseFirestore.instance;
  List<Widget> lists = new List<Widget>();

  bool loadingData = true;

  @override
  void initState() {
    super.initState();

    getFacultyInfoDataList();
  }

  getFacultyInfoDataList() {
    _firestore
        .collection("FacultyInfo")
        .where("department", isEqualTo: dept)
        .get()
        .then((value) {
      for (var document in value.docs) {
        lists.add(ListComponent(
          avatarUrl: document.get("avatarUrl").toString(),
          fullName: document.get("fullName").toString(),
          eID: document.get("empid").toString(),
        ));
      }

      setState(() {
        loadingData = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faculty Information"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: loadingData
          ? Loading()
          : ListView(
              children: lists.toList(),
            ),
    );
  }
}

class ListComponent extends StatelessWidget {
  ListComponent(
      {Key key,
      @required this.avatarUrl,
      @required this.fullName,
      @required this.eID})
      : super(key: key);

  final String fullName;
  final String eID;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ShowDetail(eID: eID);
        }));
      },
      child: Container(
        height: 80.0,
        width: double.infinity,
        decoration: BoxDecoration(border: Border.all(color: Colors.amber)),
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.memory(base64Decode(avatarUrl)),
              // child: Image(
              //   image: new AssetImage("images/sgsits_logo.png"),
              // ),
            ),
            SizedBox(
              height: 10.0,
              width: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fullName,
                  style: TextStyle(fontSize: 20.0),
                ),
                Text(
                  "EID: $eID",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 16.0,
                    color: Color.fromARGB(255, 125, 125, 125),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
