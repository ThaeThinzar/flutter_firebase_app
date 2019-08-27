import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_firebase_app/Models/message.dart';
class MessagePage extends StatefulWidget {
  @override
  MessagePageState createState() {
    return MessagePageState();
  }

}
class MessagePageState extends State<MessagePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic> message) async{
        print('onMessage $message');
        final notification = message['notification'];
        setState(() {
          messages.add(Message(
            title: notification['title'], body: notification['body']
          ));
        });
      },
      onLaunch: (Map<String,dynamic> message) async{
        print('onLanch : $message');
      },
      onResume: (Map<String,dynamic> message) async{
        print('onResume: $message');
      }
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings( sound:  true, badge: true, alert: true),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('NOtification'),
      ),
      body:  ListView(
        children: messages.map(buildMesssage).toList(),
      ),
    );

  }
  Widget  buildMesssage(Message message ) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );
}