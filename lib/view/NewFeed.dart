import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Helpers/Constants.dart';
import 'package:intl/intl.dart';
class NewFeed extends StatefulWidget{

  @override
  _NewFeedState createState() {
    return _NewFeedState();
  }
}

class _NewFeedState extends State<NewFeed> {
  Widget titleSection = Container(
    padding: const EdgeInsets.all(24),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    _bindTextView('Vingere Science',0,16),
                    _bindTextView('@VingereSCience',4,16),
                    _bindTextView('8m',70,12),

                  ],
                ),
              ),
              Text(
                'UNESCO World Heritage Site located in the Mandalay Region of Myanmar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  final logo = CircleAvatar(
    backgroundColor: Colors.transparent,
    radius: 20,
    child: Image.asset('assets/images/profile.jpg',fit: BoxFit.cover,),
  );
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner:false,
      home: Scaffold(

        backgroundColor: Colors.blueGrey,

        appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () => Navigator.pop(context, false),
          ),

          actions: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {}
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.message
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.person_add,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                        Icons.search
                    ),
                    onPressed: () {},
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: IconButton(

                          ),
                        )
                      ];
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        body: _buildList(context)

      ),
    );
  }

  Widget _buildList(BuildContext context){
    List<String> users =['John Smith', 'Daatta','Jennie','Rose','Lisa','Daniel','Honey','Kailly','Marry','Kyar'];
    List<Image> newFeedImages = [appLogo,baganover,appLogo,mdy,yangon,appLogo,baganover,yangon,mdy,yangon];
    List<String> profileImages =['https://fiverr-res.cloudinary.com/t_profile_original,q_auto,f_auto/attachments/profile/photo/23c881fae77540e099874c42f8be8e0c-1503036268667/5e7da83f-a477-4a82-81f8-884234026722.jpg',
                                  'https://sketchmob.com/wp-content/uploads/2017/04/6668_75050ac8-347x347.png',
                                  'https://www.classifapp.com/wp-content/uploads/2017/09/avatar-placeholder.png',
                                  'http://www.parttimely.com/wp-content/uploads/2018/10/justin-bieber-wallpaper-for-mobail-500x357.jpg',
                                  'https://www.classifapp.com/wp-content/uploads/2017/09/avatar-placeholder.png',
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkmDsJ2i2tMG2_V4oU1o-WlLp0fUJn-RBBt51Mai7TMAVoLJvR',
                                  'https://sketchmob.com/wp-content/uploads/2017/04/6668_75050ac8-347x347.png',
                                  'https://fiverr-res.cloudinary.com/t_profile_original,q_auto,f_auto/attachments/profile/photo/23c881fae77540e099874c42f8be8e0c-1503036268667/5e7da83f-a477-4a82-81f8-884234026722.jpg',
      'https://www.classifapp.com/wp-content/uploads/2017/09/avatar-placeholder.png',
      'https://www.classifapp.com/wp-content/uploads/2017/09/avatar-placeholder.png'
    ];


    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
        int selection = new Random().nextInt(100);
        int count = index +selection;
        return _buildNewFeedItem(users[index],count,newFeedImages[index], profileImages[index]);
      }
    );
  }



  Container _buildNewFeedItem(String userName,int count, Image newFeedImage,String profileImage) {

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy  hh:mm a').format(now);
    Widget buttonSection = Container(
      width: MediaQuery.of(context).size.width*0.70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildReactionIcon(Icons.undo, count.toString()),
          _buildReactionIcon(Icons.repeat, count.toString()),
          _buildReactionIcon(Icons.favorite, count.toString()),
        ],
      ),
    );
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        color: Colors.white,
        elevation: 3.0,
        child:Container(
          margin: EdgeInsets.only(top: 12,left: 8,right: 8),
          width: MediaQuery.of(context).size.width*0.8,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left:4,right: 8),
                height: 40,
                width: 40,
                child:
                 CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(
                    profileImage
                  ),
                ),

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _bindTextView(userName,0,16),
                      _bindTextView('@$userName',4,16),
                    ],
                  ),
                  Row(
                    children: <Widget>[

                      _bindTextView('$formattedDate',0,12),
                    ],
                  ),
                  Container(
                    //padding: EdgeInsets.only(bottom: 4),
                    width: MediaQuery.of(context).size.width*0.73,
                    child: newFeedImage != null ? newFeedImage : appLogo,
                  ),
                  buttonSection,
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}

  Container _buildReactionIcon(IconData iconData, String count){
    return Container(
      child: Row(
        children: <Widget>[
        IconButton(
        icon: Icon(iconData),
        color: Colors.white,
      ),
      Container(
        child: Text(
            count,
            style: TextStyle(
                color: Colors.black54
            )
         ),
         ),
        ],
      ),



    );

}
  Column _bindTextView (String inputText, double paddLeft, double size){
    return Column(

      children: <Widget>[
        Container(
          padding:  EdgeInsets.only(left: paddLeft, bottom: 8),
          child: Text(
            inputText,
            style: TextStyle(color: Colors.black54, fontSize: size),
          ),

        )
      ],
    );

  }
