import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'MusicPage.dart';
import 'NestedTabs/HomeForYourTabs.dart';
import 'NestedTabs/HomeTopTab.dart';
import 'NestedTabs/MoviewTopTabs.dart';

/*
class MyHomePage extends StatelessWidget {

  */
/*final FirebaseAuth _auth = FirebaseAuth.instance;
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

  }*//*


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

}*/

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() {

    return MyHomePageState();
  }

}
Color PrimaryColor =  Color(0xff2679f3);
class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
       appBar: AppBar(
         backgroundColor: PrimaryColor,
         title: Padding(
           padding: EdgeInsets.only(top: 8),
           child: googlePlayAppBar(),
         ),
         bottom: TabBar(
           isScrollable: true,
           indicatorColor: Colors.white,
           indicatorWeight: 6.0,
/*           onTap: (index){
             switch (index) {
               case 0:
                 PrimaryColor= Colors.teal;
                 break;
               case 1:
                 PrimaryColor= Colors.lightGreen;
                 break;
               case 3:
                 PrimaryColor= Color(0xff2679f3);
                 break;
               case 4:
                 PrimaryColor = Colors.amber;
                 break;

               default:
             }
           }*/
           tabs: <Widget>[
             Tab(
               child: Container(
                 child: Text(
                   'HOME',
                   style: TextStyle(color: Colors.white, fontSize: 18.0),
                 ),
               ),
             ),

             Tab(
               child: Container(
                 child: Text(
                   'MOVIES',
                   style: TextStyle(color: Colors.white, fontSize: 18.0),
                 ),
               ),
             ),
             Tab(
               child: Container(
                 child: Text(
                   'MUSICS',
                   style: TextStyle(color: Colors.white, fontSize: 18.0),
                 ),
               ),
             ),
             Tab(
               child: Container(
                 child: Text(
                   'BOOKs',
                   style: TextStyle(color: Colors.white, fontSize: 18.0),
                 ),
               ),
             ),
           ],
         ),
       ),
        body: TabBarView(
          children: <Widget>[
            HomeForYouTabs(),
            MovieTopTabs(0xf4551678),
            MusicPage(0xff46565e),
            HomeTopTabs(0xfffeeaef),
          ],
        ),
      ),
    );
  }

  Widget googlePlayAppBar() {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        SizedBox(width: 8,),
      Icon(Icons.menu,color: Colors.grey,),
      SizedBox(
        width: 8.0,
      ),
      Expanded(
        child: TextField(
          decoration: InputDecoration(
              hintText: 'Search ...',
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none),
        ),
      ),
          SizedBox(width: 8,),
          Icon(Icons.search,color: Colors.grey,),
        ]
      ),
    );
  }

}