import 'package:flutter/material.dart';
import 'package:faculty_info/shared/customlisttile.dart';
import 'package:faculty_info/screens/authenticate/register.dart';
import 'package:faculty_info/screens/authenticate/sign_in.dart';
import 'package:faculty_info/screens/home/dashboard.dart';
import 'package:faculty_info/screens/map/fullmap.dart';
import 'package:faculty_info/screens/map/collegemap.dart';

class InkWellDrawer extends StatelessWidget {
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
              Icons.dashboard,
              'DashBoard',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => new DashBoard()))
                  }),
          CustomListTile(
              Icons.app_registration,
              'Register',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => new Register()))
                  }),
          CustomListTile(
              Icons.login,
              'Login',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(ctxt,
                        new MaterialPageRoute(builder: (ctxt) => new SignIn()))
                  }),
          CustomListTile(
              Icons.map,
              'Map',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(ctxt,
                        new MaterialPageRoute(builder: (ctxt) => new FullMap()))
                  }),
          CustomListTile(
              Icons.map,
              'College Map',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.push(
                        ctxt,
                        new MaterialPageRoute(
                            builder: (ctxt) => new CollegeMap()))
                  }),
        ],
      ),
    );
  }
}
