import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Helpers/Util.dart';
import 'package:toast/toast.dart';
import 'dart:async';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'HomePage.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget{
  RegisterPage({Key key}) : super(key: key);
  @override
  _RegisterPageState createState() {

    return _RegisterPageState();
  }

}
class _RegisterPageState extends State<RegisterPage> {
  String  _date ;
  final format = DateFormat("dd/MM/yyyy");
  DateTime selectedDate = DateTime.now();
  final lastFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final rePasswordFocus  = FocusNode();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController dobController;
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
                  autofocus: true,
                  onFieldSubmitted: (v){
                    FocusScope.of(context).requestFocus(lastFocus);
                  },
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
                  focusNode: lastFocus,
                  onFieldSubmitted: (v){
                    FocusScope.of(context).requestFocus(emailFocus);
                  },
                  textInputAction: TextInputAction.next,
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
                  focusNode: emailFocus,
                ),
               InkWell(
                 onTap: () {
                   _selectDate(context);
                 },
                 child: IgnorePointer(
                   child: new TextFormField(
                     decoration: InputDecoration(
                       labelText: _date?? 'Date of birth '
                     ),
                     onSaved: (String dob){},
                     controller: dobController,
                     keyboardType:TextInputType.datetime,
                   ),
                 ),
               ),
               /* DateTimeField(
                  format: format,
                  decoration: InputDecoration( labelText:  ' Date of birth '),
                  onChanged: (dt) => setState(()=> date = dt),
                ),*/
               /* FlatButton(
                  child: new Row(
                    children: <Widget>[
                      Text('$format.format(date'),
                      Icon(Icons.date_range)
                    ],
                  ),
                  onPressed: () async{
                    final dtPick = await showDatePicker(context: context,
                        initialDate: new DateTime.now(),
                        firstDate: new DateTime(2000),
                        lastDate: new DateTime(2100));
                    if(dtPick != null && dtPick != _date){
                      setState(() {
                        date = dtPick;
                        print('date : $_date');
                      });
                    }
                  },
                ),*/
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password*', hintText: "********"),
                  controller: pwdInputController,
                  obscureText: true,
                  validator: utils.pwdValidator,
                  onFieldSubmitted: (v){
                    FocusScope.of(context).requestFocus(rePasswordFocus);
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirm Password*', hintText: "********"),
                  controller: confirmPwdInputController,
                  obscureText: true,
                  focusNode: rePasswordFocus,
                  validator: utils.pwdValidator,
                  textInputAction: TextInputAction.done,
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
                            "dob":_date,
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
                            dobController.clear(),
                            emailInputController.clear(),
                            pwdInputController.clear(),
                            confirmPwdInputController.clear()
                          })
                              .catchError((err){
                            Toast.show(err.toString(),context,duration:Toast.LENGTH_LONG);
                            print(err);
                          })
                              .catchError((err){
                            Toast.show(err.toString(),context,duration:Toast.LENGTH_LONG);
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
  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }
  Future<String> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _date = format.format(selectedDate);
      });
  }

}