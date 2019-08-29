
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Models/FriendModel.dart';

import 'ChatPage.dart';

class ContactList extends StatefulWidget {
  @override
  ContactListState createState() {
    return ContactListState();
  }

}
class ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Friends'),),
      body: Container(
        child: ListView.builder(
          itemCount: FriendModel.dummyData.length,
          itemBuilder: (context,index){
            FriendModel _model = FriendModel.dummyData[index];
            return Column(
              children: <Widget>[
                Divider(
                  height: 12.0,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(_model.profileURL),
                  ),
                  onTap: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=> ChatPage(FriendModel.dummyData[index].name)));},
                  title: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Text(_model.name),

                      SizedBox(
                        width: 12,
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14.0,
                  ),

                )
              ],
            );
          },
        ),
      ),
    );
  }

}