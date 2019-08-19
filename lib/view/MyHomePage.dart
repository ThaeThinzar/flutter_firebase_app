import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MyHomePage extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();  // return google sign in account. after that need to authenticate
   // await it and ask google sign in account
    GoogleSignInAuthentication gSignInAuth = await googleSignInAccount.authentication;
    // access firebase user
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: gSignInAuth.idToken, accessToken: gSignInAuth.accessToken);
    FirebaseUser user =  (await _auth.signInWithCredential(credential)) as FirebaseUser;// this need two param: id and access token

    return user;
  }
  void _signOut() {
    googleSignIn.signOut();
    print("User Sign out");

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Firebase Demo'),),
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _signIn().then((FirebaseUser user)=> print(user)).catchError((e)=>print(e)),
              child: Text('Sign In',style: TextStyle(color: Colors.white),),
              color: Colors.lightGreen,
            ),
            new Padding(padding: const EdgeInsets.all(10)),
            RaisedButton(
              onPressed: ()=>_signOut(),
              child: Text('Sign Out',style: TextStyle(color: Colors.white),),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

}