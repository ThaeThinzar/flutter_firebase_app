import 'package:flutter/material.dart';

import 'MusicPlayer.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicPage extends StatefulWidget {
  int color;

  MusicPage(this.color);

  @override
  MusicPageState createState() {

    return MusicPageState();
  }

}

class MusicPageState extends State<MusicPage>{
  var blueColor = Color(0xFF090e42);
  var pinkColor = Color(0xFFff6b80);
  _launchURL(String url) async {
    // url = urlLink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        children: <Widget>[
          SizedBox(height: 32.0,),
          CustomTextField(),
          SizedBox(height: 32.0),
          Text(
            'Collections',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
          SizedBox (height: 16,),
          Row(
            children: <Widget>[
              ItemCard('assets/images/lifestyle.png', 'Life Style'),
              SizedBox(
                width: 16.0,
              ),
              ItemCard('assets/images/bagan.jpg', 'Travel'),
            ],
          ),
          SizedBox (height: 32,),
          Row(
            children: <Widget>[
              ItemCard('assets/images/sport.jpg', 'Sports'),
              SizedBox(
                width: 16.0,
              ),
              ItemCard('assets/images/edm.jpg', 'Relax'),
            ],
          ),
          SizedBox(height: 32,),
          Text(
            'Recommend',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30.0),
          ),
          SizedBox(height: 16.0,),
          SongItem(context, '2019 Winner', 'OG', 'https://www.hotspawn.com/app/uploads/2019/08/og_ti9_winners-1024x683.jpeg','https://www.hotspawn.com/og-ti-2019-winners/'),
          SongItem(context,'Success Life ','Billie Eilish ','https://www.startamomblog.com/wp-content/uploads/2018/08/12-successful-lifestyle-blogs-ideas-startamomblog.com-fi.png', 'https://www.startamomblog.com/what-is-a-lifestyle-blog/'),
          SongItem(context, 'Sport Channel', 'Tommy Robin ', 'http://www.secsportsfan.com/images/best-all-time.jpg','https://www.thebestsportsblog.com/top-sports-blogs.html'),
          SongItem(context, 'Fitness & Fashion  ', 'STommy Samm', 'https://charts-static.billboard.com/img/2019/06/shawn-mendes-drf-senorita-j21-87x87.jpg','https://mediakix.com/blog/fabletics-influencer-marketing-case-study-instagram/'),




        ],
      ),
      ),
    );
  }

  Widget SongItem(BuildContext context,String title, String artist, String image,String url){
    return GestureDetector(
      onTap: (){
        _launchURL(url);
       // Navigator.push(context,MaterialPageRoute(builder: (context)=>MusicPlayer(title,artist,image)));
      },
      child: Padding(padding: const EdgeInsets.only(bottom: 26),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 80.0,
                width: 80.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  height: 80.0,
                  width: 80.0,
                  child: Icon(
                    Icons.play_circle_filled,
                    color: Colors.white.withOpacity(0.7),
                    size: 42.0,
                  ))
            ],
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24.0),
               ),
              SizedBox(height: 8,),
              Text(
                artist,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5), fontSize: 12.0),
              ),
             ]
          ),
          Spacer(),
          Icon(
            Icons.more_horiz,
            color: Colors.white.withOpacity(0.6),
            size: 32.0,
          )

        ],
      ),
    ),
    );
  }

}

class ItemCard extends StatelessWidget {
  final image;
  final title;
  ItemCard(this.image, this.title);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 120,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                    height: 140.0,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  right: 16.0,
                  top: 16.0,
                  child: Icon(
                    Icons.bookmark,
                    color: Colors.white.withOpacity(0.6),
                    size: 24.0,
                  ),),

              ],
            ),
          ),
          SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          )
        ],
      ),
    );
  }



}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.16),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8,),
          Icon(Icons.search,color: Colors.white,),
          SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search category...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Icon(
            Icons.mic,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),

        ],
      ),
    );
  }

  
}