import 'package:faculty_info/models/user.dart';
import 'package:faculty_info/screens/home/home.dart';
import 'package:faculty_info/services/auth.dart';
import 'package:faculty_info/screens/home/dashboard.dart';
import 'package:faculty_info/shared/clipping.dart';
import 'package:faculty_info/services/database.dart';
import 'package:faculty_info/shared/loading.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:faculty_info/shared/inkwelldrawer2.dart';
import 'package:faculty_info/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io' as Io;
import 'dart:convert';

class UpdateProfile extends StatelessWidget {
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
            title: Text('Update Profile'),
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

  String avatarUrl = '';
  final categoryEmp = TextEditingController();
  final contactAddress = TextEditingController();
  final contactNumber = TextEditingController();
  String department = "Information Technology";
  final designation = TextEditingController();
  final email = TextEditingController();
  final empid = TextEditingController();
  String gender = 'Male';
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

  bool loading = true;

  @override
  void initState() {
    super.initState();

    getCurrentUser();

    myController.addListener(() {
      print(myController.text);
    });
  }

  fileConvert(path) {
    final bytes = Io.File(path).readAsBytesSync();

    String img64 = base64Encode(bytes);
    return img64;
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

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  void getFacultyInfo() async {
    _firestore
        .collection('FacultyInfo')
        .doc(loggedInUser.uid)
        .get()
        .then((value) {
      if (value.exists) {
        avatarUrl = value.get("avataraurl").toString();

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
          loading = false;
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
  PickedFile imageFile;
  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.amber),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.white,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Padding(
          padding: EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: (imageFile == null)
                    ? Icon(Icons.person)
                    : Image.file(Io.File(imageFile.path)),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: raisedButtonStyle,
                  child: Text(
                    'Select Photo',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _showChoiceDialog(context);
                  }),
              SizedBox(height: 20.0),
              Text(
                '------Basic Info------',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Faculty Full Name'),
                keyboardType: TextInputType.name,
                validator: (val) => val.isEmpty ? 'Enter full name' : null,
                controller: fullName,
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.amber, width: 2.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: gender,
                    isExpanded: true,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Male',
                      'Female',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a department",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Faculty Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (val) => (val.isEmpty || val.length != 10)
                    ? 'Enter valid phone number'
                    : null,
                controller: contactNumber,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Faculty Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val.isEmpty || val == null) {
                    return 'Enter valid email address';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)) {
                    return 'Enter valid email address';
                  }

                  return null;
                },
                controller: email,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Faculty Address'),
                keyboardType: TextInputType.streetAddress,
                validator: (val) => val.isEmpty ? 'Enter address' : null,
                controller: contactAddress,
              ),
              SizedBox(height: 20.0),
              Text(
                '------Academic Info------',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Faculty Employee ID'),
                keyboardType: TextInputType.text,
                validator: (val) => val.isEmpty ? 'Enter employee id' : null,
                controller: empid,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                    textInputDecoration.copyWith(hintText: 'Faculty Category'),
                keyboardType: TextInputType.text,
                validator: (val) => val.isEmpty ? 'Enter category' : null,
                controller: categoryEmp,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Faculty Designation'),
                keyboardType: TextInputType.text,
                validator: (val) => val.isEmpty ? 'Enter designation' : null,
                controller: designation,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Faculty Highest Qualifications'),
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val.isEmpty ? 'Enter highest qualifications' : null,
                controller: qualification,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Qualification Month & Year(mm/yyyy)'),
                keyboardType: TextInputType.datetime,
                validator: (val) =>
                    (val.isEmpty) ? 'Enter month and year' : null,
                controller: yrQualification,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Faculty Social Category'),
                keyboardType: TextInputType.text,
                validator: (val) =>
                    val.isEmpty ? 'Enter social category' : null,
                controller: socialCategory,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Faculty Subjects for Teaching'),
                keyboardType: TextInputType.multiline,
                validator: (val) => val.isEmpty ? 'Enter subjects' : null,
                controller: subjectTeach,
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.amber, width: 2.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: department,
                    isExpanded: true,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Information Technology',
                      'Industrial & Production',
                      'Mechanical Department',
                      'CS Department',
                      'Civil Department',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Please choose a department",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        department = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Joining Month & Year'),
                keyboardType: TextInputType.datetime,
                validator: (val) =>
                    val.isEmpty ? 'Enter month and year(mm/yyyy)' : null,
                controller: joiningDate,
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: Colors.amber, width: 2.0)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: phd,
                    isExpanded: true,
                    //elevation: 5,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    items: <String>[
                      'Yes',
                      'No',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            value,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Are you doing phd or not.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    onChanged: (String value) {
                      setState(() {
                        phd = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: (phd == 'Yes'),
                child: TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Institute Name'),
                  keyboardType: TextInputType.text,
                  validator: (val) =>
                      val.isEmpty ? 'Enter Institute Name' : null,
                  controller: instName,
                ),
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: (phd == 'Yes'),
                child: TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Start Date'),
                  keyboardType: TextInputType.datetime,
                  validator: (val) =>
                      val.isEmpty ? 'Enter start date(mm/yyyy)' : null,
                  controller: startingYear,
                ),
              ),
              SizedBox(height: 20.0),
              Visibility(
                visible: (phd == 'Yes'),
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Research Interest'),
                  keyboardType: TextInputType.multiline,
                  validator: (val) => val.isEmpty ? 'Research Interest' : null,
                  controller: researchInterest,
                ),
              ),
              SizedBox(height: 20.0),
              SizedBox(height: 20.0),
              ElevatedButton(
                  style: raisedButtonStyle,
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);

                      CollectionReference collection =
                          _firestore.collection('FacultyInfo');

                      collection.doc(loggedInUser.uid).set({
                        'avatarUrl': fileConvert(imageFile.path),
                        "categoryEmp": categoryEmp.text,
                        "contactAddress": contactAddress.text,
                        "contactNumber": contactNumber.text,
                        "department": department,
                        "designation": designation.text,
                        "email": email.text,
                        "empid": empid.text,
                        "gender": gender,
                        "joiningDate": joiningDate.text,
                        "fullName": fullName.text,
                        "qualification": qualification.text,
                        "socialCategory": socialCategory.text,
                        "subjectTeach": subjectTeach.text,
                        "yrQualification": yrQualification.text,
                        "phd": phd,
                        "instName": instName.text,
                        "startingYear": startingYear.text,
                        "researchInterest": researchInterest.text,
                      }).then((value) {
                        setState(() {
                          loading = false;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Profile Updated'),
                          duration: Duration(seconds: 3),
                          action: SnackBarAction(
                            label: 'Okay',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (ctxt) => new Home()));
                            },
                          ),
                        ));
                      });
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ));
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }
}
