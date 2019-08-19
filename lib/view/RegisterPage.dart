import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Helpers/Util.dart';
import 'package:toast/toast.dart';
import 'dart:async';

import 'HomePage.dart';

class RegisterPage extends StatefulWidget{
  RegisterPage({Key key}) : super(key: key);
  @override
  _RegisterPageState createState() {

    return _RegisterPageState();
  }

}
class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmPwdInputController;

  @override
  void initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
   Utils utils = new Utils();
    return Scaffold(
      appBar: AppBar(title: Text('Register User'),),
      body: Container(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey, // to check invalid field
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name *',hintText: "John"
                  ),
                  controller: firstNameInputController,
                  validator: (value){
                    if(value.length < 3){
                      return 'please enter valid name';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Second Name *',hintText: "Doe"
                  ),
                  controller: lastNameInputController,
                  validator: (value){
                    if(value.length < 3){
                      return 'please enter valid name';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email*', hintText: "john.doe@gmail.com"),
                  controller: emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  validator: utils.emailValidator ,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password*', hintText: "********"),
                  controller: pwdInputController,
                  obscureText: true,
                  validator: utils.pwdValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirm Password*', hintText: "********"),
                  controller: confirmPwdInputController,
                  obscureText: true,
                  validator: utils.pwdValidator,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: RaisedButton(
                    child: Text('Register'),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed:() {
                      if(_registerFormKey.currentState.validate()){ // pass their validation or not
                        if(pwdInputController.text == confirmPwdInputController.text){ // to check password fields match or not.
                          FirebaseAuth.instance // to sign up new user
                              .createUserWithEmailAndPassword(email: emailInputController.text, password: pwdInputController.text)
                              .then((currentUser) => Firestore.instance
                              .collection("users")
                              .document(currentUser.user.uid)
                              . setData({
                            "uid": currentUser.user.uid,
                            "fname": firstNameInputController.text,
                            "surname": lastNameInputController.text,
                            "email": emailInputController.text,
                          })
                              .then((result)=> { // result of creating account
                                Toast.show("Account Registration Success.",context,duration:Toast.LENGTH_LONG),
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      title:
                                      firstNameInputController.text +
                                          "'s Tasks",
                                      uid: currentUser.user.uid,
                                    )),
                                    (_) => false),
                            firstNameInputController.clear(),
                            lastNameInputController.clear(),
                            emailInputController.clear(),
                            pwdInputController.clear(),
                            confirmPwdInputController.clear()
                          })
                              .catchError((err){
                            Toast.show(err,context,duration:Toast.LENGTH_LONG);
                            print(err);
                          })
                              .catchError((err){
                            Toast.show(err,context,duration:Toast.LENGTH_LONG);
                            print(err);
                          }));
                        } else {

                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("The passwords do not match"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Close"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              });
                        }
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?"),
                  FlatButton(
                    child: Text("Login here!",style: TextStyle(color: Colors.indigo,decoration: TextDecoration.underline),),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

}