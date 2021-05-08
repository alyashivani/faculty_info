import 'package:flutter/material.dart';
import 'package:faculty_info/shared/customlisttile.dart';
import 'package:faculty_info/screens/authenticate/updateprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:faculty_info/screens/home/dashboard.dart';
import 'package:faculty_info/screens/home/home.dart';

class InkWellDrawer2 extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext ctxt) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.amber, Colors.amber])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset("images/sgsits_logo.png",
                            fit: BoxFit.fill, height: 90, width: 90),
                      ),
                    ),
                    Text(
                      'Faculty Information',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    )
                  ],
                ),
              )),
          CustomListTile(
              Icons.person,
              'Profile',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(ctxt,
                        new MaterialPageRoute(builder: (ctxt) => new Home()))
                  }),
          CustomListTile(
              Icons.update,
              'Update Profile',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => new UpdateProfile()))
                  }),
          // CustomListTile(
          //     Icons.update,
          //     'Update Password',
          //     () => {
          //           Navigator.pop(ctxt),
          //           Navigator.push(
          //               ctxt,
          //               new MaterialPageRoute(
          //                   builder: (ctxt) => new UpdatePassword()))
          //         }),
          CustomListTile(Icons.logout, 'Logout', () async {
            await _auth.signOut();

            Navigator.push(ctxt, MaterialPageRoute(builder: (ctxt) {
              return DashBoard();
            }));
          }),
        ],
      ),
    );
  }
}
