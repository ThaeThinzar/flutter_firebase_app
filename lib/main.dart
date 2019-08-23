import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/view/HomePage.dart';
import 'package:flutter_firebase_app/view/LoginPage.dart';
import 'package:flutter_firebase_app/view/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_app/view/RegisterPage.dart';
import 'package:flutter_firebase_app/view/SplashScreen.dart';
import 'package:flutter_firebase_app/view/TaskPage.dart';
import 'package:google_sign_in/google_sign_in.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final routes = <String, WidgetBuilder>{
    '/task': (BuildContext context) => TaskPage(title: 'Task'),
    '/home': (BuildContext context) => HomePage(title: 'Home'),
    '/login': (BuildContext context) => LoginPage(),
    '/register': (BuildContext context) => RegisterPage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(),
      routes: routes,
    );
  }
}
