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

  @override
  Widget build(BuildContext context) {

    Future getImage() async{
    //  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
      //  profileImage = image;
        Toast.show('Image path: $profileImage', context,duration: Toast.LENGTH_LONG);
      });
    }


    return Scaffold(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                            width: 180,
                            height: 180,
                            child: (profileImage!=null)? Image.file(
                              profileImage,
                              fit: BoxFit.fill,
                            ):Image.asset('assets/images/bagan.jpg',fit: BoxFit.cover,)
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: Icon(Icons.camera_alt),
                      iconSize: 30,
                      onPressed: (){
                        getImage();
                      },
                    )
                  ],
                )
              ],
            )
        ),
      )
    );
  }

}