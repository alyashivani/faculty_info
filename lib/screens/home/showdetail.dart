import 'package:faculty_info/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class ShowDetail extends StatefulWidget {
  ShowDetail({Key key, @required this.eID}) : super(key: key);

  final String eID;

  @override
  _ShowDetailState createState() => _ShowDetailState(eID);
}

class _ShowDetailState extends State<ShowDetail> {
  _ShowDetailState(
    this.eID,
    // this.avatarUrl,
    // this.categoryEmp,
    // this.fullName,
    // this.gender,
    // this.contactNumber,
    // this.contactAddress,
    // this.email,
    // this.joiningDate,
    // this.department,
    // this.qualification,
    // this.designation,
    // this.phd,
    // this.researchInterest,
    // this.socialCategory,
    // this.startingYear,
    // this.subjectTeach,
    // this.yrQualification,
    // this.instName
  );
  String eID;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  bool loadingData = true;

  String error = '';

  String fullName;
  String avatarUrl;
  String contactNumber, contactAddress, gender, email;
  String department, designation, qualification, categoryEmp, socialCategory;
  String yrQualification, joiningDate;
  String subjectTeach;
  String instName, researchInterest, startingYear, phd;

  @override
  void initState() {
    super.initState();

    getFacultyInfo();
  }

  void getFacultyInfo() async {
    _firestore
        .collection("FacultyInfo")
        .where("empid", isEqualTo: eID)
        .get()
        .then((value) {
      avatarUrl = value.docs[0].get('avatarUrl').toString();
      categoryEmp = value.docs[0].get("categoryEmp").toString();
      contactAddress = value.docs[0].get("contactAddress").toString();
      contactNumber = value.docs[0].get("contactNumber").toString();
      designation = value.docs[0].get("designation").toString();
      email = value.docs[0].get("email").toString();
      eID = value.docs[0].get("empid").toString();
      gender = value.docs[0].get("gender").toString();
      department = value.docs[0].get("department").toString();
      phd = value.docs[0].get('phd').toString();
      joiningDate = value.docs[0].get("joiningDate").toString();
      fullName = value.docs[0].get("fullName").toString();
      qualification = value.docs[0].get("qualification").toString();
      socialCategory = value.docs[0].get("socialCategory").toString();
      subjectTeach = value.docs[0].get("subjectTeach").toString();
      yrQualification = value.docs[0].get("yrQualification").toString();
      instName = value.docs[0].get("instName").toString();
      researchInterest = value.docs[0].get("researchInterest").toString();
      startingYear = value.docs[0].get("startingYear").toString();

      setState(() {
        loadingData = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: loadingData
            ? Loading()
            : ListView(
                children: [
                  Stack(
                    children: [
                      Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(32.0),
                            child: Image.memory(
                              base64Decode(avatarUrl),
                              width: 128.0,
                              height: 128.0,
                              //alignment: Alignment.topCenter,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            '------Basic Info------',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text('Name: $fullName'),
                          SizedBox(height: 20.0),
                          Text('Gender: $gender'),
                          SizedBox(height: 20.0),
                          Text('Contact Number: $contactNumber'),
                          SizedBox(height: 20.0),
                          Text('Email: $email'),
                          SizedBox(height: 20.0),
                          Text('Contact Address: $contactAddress'),
                          SizedBox(height: 20.0),
                          Text(
                            '------Academic Info------',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Text('Employee Id: $eID'),
                          SizedBox(height: 20.0),
                          Text('Faculty Category: $categoryEmp'),
                          SizedBox(height: 20.0),
                          Text('Designation: $designation'),
                          SizedBox(height: 20.0),
                          Text('Qualification: $qualification'),
                          SizedBox(height: 20.0),
                          Text('Social Category: $socialCategory'),
                          SizedBox(height: 20.0),
                          Text('Subject Teach: $subjectTeach'),
                          SizedBox(height: 20.0),
                          Text('Department: $department'),
                          SizedBox(height: 20.0),
                          Text('Qualification Year: $yrQualification'),
                          SizedBox(height: 20.0),
                          Text('Joining Date: $joiningDate'),
                          SizedBox(height: 20.0),
                          Text('Enrolled for phd: $phd'),
                          SizedBox(height: 20.0),
                          Visibility(
                            visible: (phd == 'Yes'),
                            child:
                                Text('Enrolled phd month/year: $startingYear'),
                          ),
                          SizedBox(height: 20.0),
                          Visibility(
                            visible: (phd == 'Yes'),
                            child: Text('Name of Institute: $instName'),
                          ),
                          SizedBox(height: 20.0),
                          Visibility(
                            visible: (phd == 'Yes'),
                            child: Text(
                                'Area of Research Interest: $researchInterest'),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      )),
                    ],
                  )
                ],
              ));
  }
}

// class ShowData extends StatelessWidget {
//   ShowData(
//       {Key key,
//       @required this.name,
//       @required this.gender,
//       @required this.contactNumber,
//       @required this.email,
//       @required this.contactAddress,
//       @required this.categoryEmp,
//       @required this.eID,
//       @required this.designation,
//       @required this.qualification,
//       @required this.socialCategory,
//       @required this.subjectTeach,
//       @required this.department,
//       @required this.yrQualification,
//       @required this.joiningDate,
//       @required this.instName,
//       @required this.researchInterest,
//       @required this.startingYear,
//       @required this.phd})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child:
//     );
//   }
// }
