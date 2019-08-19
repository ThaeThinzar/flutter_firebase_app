import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Models/StateModel.dart';
import 'package:google_sign_in/google_sign_in.dart';
class StateWidget extends StatefulWidget {
  final StateModel state;
  final Widget child;
// Returns data of the nearest widget _StateDataWidget
  // in the widget tree.
  static _StateWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_StateDataWidget)
    as _StateDataWidget).data;
  }

  const StateWidget({Key key, this.state, this.child}) : super(key: key);
  @override
  _StateWidgetState createState() {
    return _StateWidgetState();
  }

}
class _StateWidgetState extends State<StateWidget> {
  StateModel state;
  GoogleSignInAccount googleAccount;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    if(widget.state != null){
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }
  Future<Null> initUser() async {
    googleAccount = await googleSignIn.signIn();
    if (googleAccount == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      await signInWithGoogle();
    }
  }
  Future<Null> signInWithGoogle() async {
    GoogleSignInAuthentication signInAuth;
    if (googleAccount == null) {
      // Start the sign-in process:
      googleAccount = await googleSignIn.signIn();
      signInAuth = await googleAccount.authentication;
    }
    final AuthCredential credential = GoogleAuthProvider.getCredential(idToken: signInAuth.idToken, accessToken: signInAuth.accessToken);
    FirebaseUser firebaseUser = (await _auth.signInWithCredential(credential)) as FirebaseUser;
    state.user = firebaseUser; // new
    setState(() {
      state.isLoading = false;
      state.user = firebaseUser;
    });
  }
  @override
  Widget build(BuildContext context) {

    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }

}
class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}