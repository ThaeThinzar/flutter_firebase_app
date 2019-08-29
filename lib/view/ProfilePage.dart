import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Helpers/Constants.dart' as prefix0;
import 'package:flutter_firebase_app/Models/User.dart';
import 'package:toast/toast.dart';
import 'package:path/path.dart';
import 'package:intl/intl.dart';


class ProfilePage extends StatefulWidget {
  final String uid;

  const ProfilePage({Key key, this.uid}) : super(key: key);
  @override
  ProfilePageState createState() {
    return ProfilePageState();
  }

}

class ProfilePageState extends State<ProfilePage> {

  File profileImage; // to save uploaded pic
  TextEditingController emailInputController;
  TextEditingController nameInputcontroller;
  TextEditingController phoneInputController;
  TextEditingController addressInputController;
  User profile = new User();
  final format = DateFormat("dd/MM/yyyy");
  DateTime selectedDate = DateTime.now();
  String  _date ;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
  // getUserDoc();
  }
  @override
  Widget build(BuildContext context) {

    Future getImage() async{
    //  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
      //  profileImage = image;
        Toast.show('Image path: $profileImage', context,duration: Toast.LENGTH_LONG);
      });
    }

    Widget createProfileField(String name, IconData icon,TextEditingController controller){
      return Container(
        margin: EdgeInsets.all(8),
        child:Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.7,
                  child: Row(
                    children: <Widget>[
                      Icon(icon),
                      SizedBox(width:20),
                      Text(name, style:TextStyle(color:Colors.black, fontSize: 16)),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  child:  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      if(name.contains('/')){
                        _pickedDate(context);
                      } else {
                        _asyncInputDialog(context,name,);
                      }
                      },
                  ),
                )

              ],
            ),
            SizedBox(height: 5,),


            /*TextFormField(
              decoration: InputDecoration(
                  hintText: name,
                  prefixIcon: Icon(icon)
              ),
              controller: controller,
            ),*/

           // Divider(color:Colors.black45, height:5)
           ]
        )
      );
    }

    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').snapshots(),
      builder: (context,snapshot) {

        if(!snapshot.hasData){
          return Text('Loading data please wait ...');
        } else {
          getUserDoc(snapshot.data.documents);
        }
        return Scaffold(
          appBar: AppBar(title: Text('Profile'),),
          backgroundColor: Colors.grey,
          body: new ListView(
            children: <Widget>[
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xff476cfb),
                          child: ClipOval(
                            child: new SizedBox(
                                width: 100,
                                height: 100,
                                child: (profileImage!=null)? Image.file(
                                  profileImage,
                                  fit: BoxFit.fill,
                                ):Image.asset('assets/images/bagan.jpg',fit: BoxFit.cover,)
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              child: Text('Upload Profile'),
                              onPressed:(){null;}
                          ),
                        ),
                        Container(

                            margin:EdgeInsets.all(8),
                            child:Card(
                                child: Column(
                                  children: <Widget>[
                                    createProfileField( profile.uid != null ?snapshot.data.documents[profile.uid]['fname']: 'Loading....',Icons.person, nameInputcontroller),
                                    Divider(height: 5, color:Colors.grey ),
                                    createProfileField(profile.uid != null?snapshot.data.documents[profile.uid]['email']:'Loading...',Icons.alternate_email, emailInputController),
                                    Divider(height: 5, color:Colors.grey ),
                                    createProfileField(profile.uid!=null? snapshot.data.documents[profile.uid]['dob']:'Loading...',Icons.calendar_today, phoneInputController),
                                    /*InkWell(
                                      onTap: () {
                                        _pickedDate(context);
                                      },
                                      child: IgnorePointer(
                                        child: Row(
                                          children: <Widget>[
                                            new TextFormField(
                                              decoration: InputDecoration(
                                                  labelText: _date?? 'Date of birth '
                                              ),
                                              onSaved: (String dob){},
                                              controller: phoneInputController,
                                              keyboardType:TextInputType.datetime,
                                            ),
                                          ],
                                        )
                                      ),
                                    ),*/
                                    Divider(height: 5, color:Colors.grey ),
                                    createProfileField('No.parami, torkj, jgkdjsgj',Icons.home, addressInputController),
                                    SizedBox(height:10)
                                  ],
                                ),
                                color:Colors.white
                            )
                        ),

                      ],


                    )
                  ],

                ),
              )
            ],
          ),
        );
      },


    );
  }

  Future<void> _ackAlert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: const Text('This item is no longer available'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<String> _asyncInputDialog(BuildContext context,String category) async {
    String teamName = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Profile'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                    autofocus: true,
                    decoration: new InputDecoration(
                        hintText: category),
                    onChanged: (value) {
                      teamName = value;
                    },
                  )),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop(teamName);
              },
            ),
          ],
        );
      },
    );
  }

  Future<DocumentReference> getUserDoc(List<DocumentSnapshot> userDocument) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    DocumentReference ref = _firestore.collection('users').document(user.uid);
    String uid;
    uid = user.uid;
    for( int i =0; i<userDocument.length;i++){
      String docuid = userDocument[i].data['uid'];
      if(uid == userDocument[i].data['uid']){
        profile.uid = i;
      }
    }
    print ("ref;: "+ ref.toString());
    return ref;
  }

  Future<String> _pickedDate(BuildContext context) async {
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