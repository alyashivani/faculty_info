import 'dart:convert';
import 'package:faculty_info/models/user.dart';
import 'package:faculty_info/services/auth.dart';
import 'package:faculty_info/screens/home/dashboard.dart';
import 'package:faculty_info/shared/clipping.dart';
import 'package:faculty_info/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faculty_info/shared/inkwelldrawer2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:faculty_info/shared/loading.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
        initialData: [],
        value: DatabaseService().faculties,
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: InkWellDrawer2(),
          appBar: AppBar(
            backgroundColor: Colors.amber,
            elevation: 0.0,
            title: Text('Profile'),
            actions: <Widget>[
              ElevatedButton.icon(
                icon: Icon(Icons.person),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return DashBoard();
                  }));
                },
              ),
            ],
          ),
          body: ListView(children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: ClipPath(
                    clipper: ClippingClass(),
                    child: Container(
                      height: 80.0,
                      decoration: BoxDecoration(color: Colors.grey[850]),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 90.0,
                      width: 90.0,
                      decoration: BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("images/sgsits_logo.png"),
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: ProfileForm(),
            )
          ]),
        ));
  }
}

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final _formKey = GlobalKey<FormState>();
  String error = '';
  final _firestore = FirebaseFirestore.instance;
  User loggedInUser;
  final _auth = FirebaseAuth.instance;

  bool loadingData = false;
  String avatarUrl = '';
  final categoryEmp = TextEditingController();
  final contactAddress = TextEditingController();
  final contactNumber = TextEditingController();
  String department = "Information Technology";
  final designation = TextEditingController();
  final email = TextEditingController();
  final empid = TextEditingController();
  String gender = 'Male';
  // DateTime joiningDate = DateTime.now();
  final joiningDate = TextEditingController();
  final fullName = TextEditingController();
  final qualification = TextEditingController();
  final socialCategory = TextEditingController();
  final subjectTeach = TextEditingController();
  final yrQualification = TextEditingController();
  String phd = "No";
  final instName = TextEditingController();
  final startingYear = TextEditingController();
  final researchInterest = TextEditingController();

  @override
  void initState() {
    super.initState();

    getCurrentUser();

    myController.addListener(() {
      print(myController.text);
    });
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        getFacultyInfo();
      }
    } catch (e) {
      print(e);
    }
  }

  void getFacultyInfo() async {
    DocumentReference facultyInfo =
        _firestore.collection('FacultyInfo').doc(loggedInUser.uid);

    facultyInfo.get().then((value) {
      if (value.exists) {
        avatarUrl = value.get('avatarUrl').toString();
        categoryEmp.text = value.get("categoryEmp").toString();
        contactAddress.text = value.get("contactAddress").toString();
        contactNumber.text = value.get("contactNumber").toString();
        designation.text = value.get("designation").toString();
        email.text = value.get("email").toString();
        empid.text = value.get("empid").toString();
        setState(() {
          gender = value.get("gender").toString();
          department = value.get("department").toString();
          phd = value.get('phd').toString();
          loadingData = false;
        });
        joiningDate.text = value.get("joiningDate").toString();
        fullName.text = value.get("fullName").toString();
        qualification.text = value.get("qualification").toString();
        socialCategory.text = value.get("socialCategory").toString();
        subjectTeach.text = value.get("subjectTeach").toString();
        yrQualification.text = value.get("yrQualification").toString();
        instName.text = value.get("instName").toString();
        researchInterest.text = value.get("researchInterest").toString();
        startingYear.text = value.get("startingYear").toString();
      }
    });
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return loadingData
        ? Loading()
        : Form(
            key: _formKey,
            child: Padding(
              padding:
                  EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  // GFAvatar(
                  //   backgroundImage: NetworkImage(avatarUrl),
                  // ),
                  avatarUrl == ""
                      ? Icon(Icons.person)
                      : Image.memory(base64Decode(avatarUrl)),

                  //Image.file(base64Decode(avatarUrl)),

                  SizedBox(height: 20.0),
                  Text(
                    '------Basic Info------',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Name: ${fullName.text}'),
                  SizedBox(height: 20.0),
                  Text('Gender: $gender'),
                  SizedBox(height: 20.0),
                  Text('Contact Number: ${contactNumber.text}'),
                  SizedBox(height: 20.0),
                  Text('Email: ${email.text}'),
                  SizedBox(height: 20.0),
                  Text('Contact Address: ${contactAddress.text}'),
                  SizedBox(height: 20.0),
                  Text(
                    '------Academic Info------',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text('Employee Id: ${empid.text}'),
                  SizedBox(height: 20.0),
                  Text('Faculty Category: ${categoryEmp.text}'),
                  SizedBox(height: 20.0),
                  Text('Designation: ${designation.text}'),
                  SizedBox(height: 20.0),
                  Text('Qualification: ${qualification.text}'),
                  SizedBox(height: 20.0),
                  Text('Social Category: ${socialCategory.text}'),
                  SizedBox(height: 20.0),
                  Text('Subject Teach: ${subjectTeach.text}'),
                  SizedBox(height: 20.0),
                  Text('Department: $department'),
                  SizedBox(height: 20.0),
                  Text('Qualification Year: ${yrQualification.text}'),
                  SizedBox(height: 20.0),
                  Text('Joining Date: ${joiningDate.text}'),
                  SizedBox(height: 20.0),
                  Text('Enrolled for phd: $phd'),
                  SizedBox(height: 20.0),
                  Visibility(
                    visible: (phd == 'Yes'),
                    child:
                        Text('Enrolled phd month/year: ${startingYear.text}'),
                  ),

                  SizedBox(height: 20.0),
                  Visibility(
                    visible: (phd == 'Yes'),
                    child: Text('Name of Institute: ${instName.text}'),
                  ),
                  SizedBox(height: 20.0),
                  Visibility(
                    visible: (phd == 'Yes'),
                    child: Text(
                        'Area of Research Interest: ${researchInterest.text}'),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ));
  }
}
