import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:faculty_info/screens/home/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/authenticate/forgotpassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faculty Information',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Splash(),
      debugShowCheckedModeBanner: false,
      routes: {
        ForgotPassword.id: (context) => ForgotPassword(),
      },
    );
  }
}
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<User>.value(
//       value: AuthService().user,
//       child: MaterialApp(
//         home: Wrapper(),
//       ),
//     );
//   }
// }

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: new DashBoard(),
      title: new Text(
        'SGSITS Faculty Information and Map view',
        textScaleFactor: 2,
      ),
      image: Image.asset(
        'images/sgsits_logo.png',
        fit: BoxFit.fill,
      ),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.grey[850],
      backgroundColor: Colors.amber,
    );
  }
}
