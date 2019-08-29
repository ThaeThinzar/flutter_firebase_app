import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_app/Helpers/Constants.dart';
import 'package:flutter_firebase_app/Helpers/Util.dart';
import 'package:flutter_firebase_app/Models/User.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toast/toast.dart';

import 'HomePage.dart';

class LoginPage extends StatefulWidget{

  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }

}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  User profileuser = new User();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isLoggedIn;
  Future<AuthResult> _signIn() async{

    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();  // return google sign in account. after that need to authenticate
    // await it and ask google sign in account
    GoogleSignInAuthentication gSignInAuth = await googleSignInAccount.authentication;
    // access firebase user
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: gSignInAuth.idToken, accessToken: gSignInAuth.accessToken);
    // this need two param: id and access token
    
    return await _auth.signInWithCredential(credential);
  }

  void signInCheck(){
    FirebaseAuth.instance.currentUser().then((user){
      if(user!= null){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                  title: user.displayName + "'s Tasks",
                  uid: user.uid,
                )));

      }
      else {
        _signIn();

      }
    });
  }
  @override
  void initState() {
    isLoggedIn = false;
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Utils utils = new Utils();

    Widget dividerSection = Container(
      margin: const EdgeInsets.only(top: 20,bottom: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(5),
                child: Divider(
                  color: Colors.black54,
                  height: 5,
                )),
          ),
          Text("OR"),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(5),
                child: Divider(
                  color: Colors.black54,
                  height: 5,
                )),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
          child: Form(
            key: _loginFormKey,
            child: Column(
              children: <Widget>[
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
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: RaisedButton(
                    child: Text("Login"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_loginFormKey.currentState.validate()) {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                            email: emailInputController.text,
                            password: pwdInputController.text)
                            .then((currentUser) => Firestore.instance
                            .collection("users")
                            .document(currentUser.user.uid)
                            .get()
                            .then((DocumentSnapshot result) =>{
                            print('userid : $profileuser'),
                            Toast.show("Login Success $profileuser",context,duration: Toast.LENGTH_LONG),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                      title: result["fname"] +
                                          "'s Home",
                                      uid: currentUser.user.uid,
                                    )
                                )
                            )
                            })
                            .catchError((err){
                              Toast.show(err.toString(), context,duration: Toast.LENGTH_LONG);
                              print("Error: "+ err.toString());
                        }))
                            .catchError((err) {
                              Toast.show(err.toString(), context,duration: Toast.LENGTH_LONG);
                              print("Error: "+ err.toString());
                        });
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account yet?"),
                      FlatButton(
                        child: Text("Register here!",style: TextStyle(color: Colors.indigo,decoration: TextDecoration.underline),),
                        onPressed: () {
                          Navigator.pushNamed(context, "/register");
                        },
                      )
                    ],
                  ),
                ),
                dividerSection,
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SignInButton(
                        Buttons.Google,
                        mini: false,
                        onPressed: () => {
                          _signIn().then((AuthResult result){
                            Firestore.instance.collection("users")
                            .document(result.user.uid)
                            .setData({
                              "uid": result.user.uid,
                              "fname":result.user.displayName,
                              "email":result.user.email
                            });
                            Toast.show("Success", context,duration: Toast.LENGTH_LONG);
                            Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=> HomePage(
                              title: result.user.displayName +
                                  "'s Home",
                              uid: result.user.uid,
                            )));
                          })
                        }
                       // onPressed: (){signInCheck();},
                        //onPressed: () {Navigator.push(context, SlideRightRoute(page:IncreasePage(BasicCounterPresenter(),title: 'Increase Counter')));},
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