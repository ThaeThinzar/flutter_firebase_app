import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class ProfilePage extends StatefulWidget {
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
                    onPressed: (){_asyncInputDialog(context,name,);},
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

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Builder(
        builder: (context)=> Container(
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
                    /*IconButton(
                      icon: Icon(Icons.camera_alt),
                      iconSize: 30,
                      onPressed: (){
                        getImage();
                      },
                    )*/
                  ],
                ),
                Container(
                  margin:EdgeInsets.all(8),
                  child:Card(
                      child: Column(
                        children: <Widget>[
                          createProfileField('Kaing',Icons.person, nameInputcontroller),
                          Divider(height: 5, color:Colors.grey ),
                          createProfileField('ttks154@gmail.com',Icons.alternate_email, emailInputController),
                          Divider(height: 5, color:Colors.grey ),
                          createProfileField('0946314852',Icons.add_call, phoneInputController),
                          Divider(height: 5, color:Colors.grey ),
                          createProfileField('No.paremi, torkj, jgkdjsgj',Icons.home, addressInputController),
                          SizedBox(height:10)
                        ],
                      ),
                      color:Colors.white
                  )
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text('Edit'),
                      onPressed:(){_asyncInputDialog(context);}
                  ),

                )
              ],
            )
        ),
      )
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
}