import 'package:faculty_info/screens/authenticate/register.dart';
import 'package:faculty_info/screens/home/home.dart';
import 'package:faculty_info/services/auth.dart';
import 'package:faculty_info/shared/constants.dart';
import 'package:faculty_info/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:faculty_info/shared/inkwelldrawer.dart';
import 'package:faculty_info/shared/clipping.dart';
import 'package:faculty_info/screens/authenticate/forgotpassword.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            drawer: InkWellDrawer(),
            appBar: AppBar(
              backgroundColor: Colors.amber,
              elevation: 0.0,
              title: Text('Sign In'),
              actions: <Widget>[
                ElevatedButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Register();
                      }),
                    );
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
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          style: raisedButtonStyle,
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result = await _auth
                                  .signInWithEmailAndPassword(email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error =
                                      'Could not sign in with those credentials';
                                });
                              } else {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Home();
                                }));
                              }
                            }
                          }),
                      SizedBox(height: 12.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ForgotPassword.id,
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              )
            ]),
          );
  }
}
