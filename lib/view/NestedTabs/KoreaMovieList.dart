import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Models/movie/MovieListViewModel.dart';
import 'package:flutter_firebase_app/Models/movie/MovieViewModel.dart';

class KoreaMovieList extends StatefulWidget {

  MovieListViewModel movieListViewModel;
  KoreaMovieList({movieListViewModel}) {
    this.movieListViewModel = movieListViewModel;
  }
  @override
  KoreaMovieListState createState() {
    return KoreaMovieListState();
  }

}
class KoreaMovieListState extends State<KoreaMovieList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 20,),
          InstalledApps("Recommanded for you"),
          SizedBox(height: 20,),
          InstalledApps("Trending")

        ],
      ),
    );
  }
  Widget InstalledApps(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: labelContainer(title),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: appsRecommendedContainer(title),
          ),
        ],
      ),
    );
  }
  Widget labelContainer(String labelVal) {
    return Container(
      height: 30.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            labelVal,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),
          ),
        ],
      ),
    );
  }
  Widget appsRecommendedContainer(String title){
    if(title.toString() == "Trending"){
      return Container(
          height: 250,
          child: ListView.builder(itemBuilder: (context,index) {
            return KoreaMovieView(
              movieViewModel: this.widget.movieListViewModel
                  .TrendingViewModels[index],
            );
          },
            itemCount: this.widget.movieListViewModel.TrendingViewModels.length,
            scrollDirection: Axis.horizontal,)

      );

    } else {
      return Container(
          height: 250,
          child: ListView.builder(itemBuilder: (context,index) {
            return KoreaMovieView(
              movieViewModel: this.widget.movieListViewModel
                  .movieViewModels[index],
            );
          },
            itemCount: this.widget.movieListViewModel.movieViewModels.length,
            scrollDirection: Axis.horizontal,)

      );
    }

  }
}


class KoreaMovieView extends StatefulWidget {
  MovieViewModel movieViewModel;

  KoreaMovieView({movieViewModel}) {
    this.movieViewModel = movieViewModel;
  }

  @override
  KoreaMovieViewState createState() {
    return KoreaMovieViewState();
  }

}
class KoreaMovieViewState extends State<KoreaMovieView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ItemView()
    );
  }

  Widget ItemView () {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          new Card(
           color: Colors.white70,
          child: new Container(
            margin: EdgeInsets.all(8),
            child: new Column(
              children: <Widget>[
                Container(
                  height: 160,
                  width: 100,
                  decoration: new BoxDecoration(
                    image: DecorationImage(
                      image: new NetworkImage(this.widget.movieViewModel.movie.imageUrl),
                      fit: BoxFit.fill,
                    ),
                    borderRadius:BorderRadius.circular(10),),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  this.widget.movieViewModel.movie.movieName,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ],
            ),
          )
      ),

        ],
      ),
    );
  }
}