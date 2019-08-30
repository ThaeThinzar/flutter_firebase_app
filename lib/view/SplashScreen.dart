import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'HomePage.dart';
import 'LoginPage.dart';
import 'MyHomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashSceenState createState() {
    return SplashSceenState();
  }

}
class SplashSceenState extends State<SplashScreen> {
  /*Timer _timer;
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;
  SplashSceenState(){
     _timer = new Timer(const Duration(seconds: 2),(){
       setState(() {
         _logoStyle = FlutterLogoStyle.horizontal;
       });
     });
  }*/
  @override
  void initState() {
    // to see user already login or not
    FirebaseAuth.instance
    .currentUser().then((currentUser) => {
      if (currentUser == null)
        {Navigator.pushReplacementNamed(context, "/login")}
      else
        { // already login
          Firestore.instance
              .collection("users")
              .document(currentUser.uid)
              .get()
              .then((DocumentSnapshot result) => // to document from firestore
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                        title: result["fname"] + "'s Home",
                        uid: currentUser.uid,
                      ))))
              .catchError((err) => print(err))
        }
      }).catchError((err)=> print(err));
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/background.jpg'),
          fit: BoxFit.cover
          ),
        ),
        child: new Center(
          child:
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
          ),
        )
    );
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5),onDoneLoading);
}
  onDoneLoading() async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
  }
}