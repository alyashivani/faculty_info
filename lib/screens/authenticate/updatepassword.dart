import 'package:faculty_info/models/user.dart';
import 'package:faculty_info/services/auth.dart';
import 'package:faculty_info/screens/home/dashboard.dart';
import 'package:faculty_info/shared/clipping.dart';
import 'package:faculty_info/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:faculty_info/shared/inkwelldrawer2.dart';
import 'package:faculty_info/services/database.dart';

class UpdatePassword extends StatelessWidget {
  final AuthService _auth = AuthService();
  String newpassword, repeatpassword, currentpassword;

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
            title: Text('Update Password'),
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
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                  child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Current Password'),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) => val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    //controller: currentpassword,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration:
                        textInputDecoration.copyWith(hintText: 'New Password'),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) => val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    //controller: newpassword,
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(
                        hintText: 'Repeat Password'),
                    keyboardType: TextInputType.visiblePassword,
                    validator: (val) => val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    //controller: repeatpassword,
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                      style: raisedButtonStyle,
                      onPressed: () async {
                        // if (newpassword == repeatpassword &&
                        //     currentUser.password == currentpassword) {
                        //   currentUser.updatePassword(newpassword);
                        // }
                      },
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              )),
            )
          ]),
        ));
  }
}
