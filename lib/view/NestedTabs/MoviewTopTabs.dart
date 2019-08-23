import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/Models/movie/MovieListViewModel.dart';

import 'KoreaMovieList.dart';
import 'MovieReleaseTabs.dart';

class MovieTopTabs extends StatefulWidget {

  int color;

  MovieTopTabs(this.color);

  @override
  _MovieTopTabsState createState() {
    return _MovieTopTabsState();
  }

}
class _MovieTopTabsState extends State<MovieTopTabs> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection() {
    setState(() {
      widget.color=0xffff5722;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorWeight: 4,
            indicatorColor: Colors.amber,
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.live_tv, color: _tabController.index == 4
                    ? Color( widget.color)
                    : Colors.grey),
                child:Text('English',style: TextStyle( color: _tabController.index == 0
                    ?  Color( widget.color)
                    : Colors.grey,
                    fontSize: 16)),
              ),
              Tab(
                  icon: Icon(Icons.tv, color: _tabController.index == 4
                      ? Color( widget.color)
                      : Colors.grey),
                child:Text('Korea',style: TextStyle( color: _tabController.index == 1
                    ?  Color( widget.color)
                    : Colors.grey,
                    fontSize: 16)),
              ),
              Tab(
                  icon: Icon(Icons.live_tv, color: _tabController.index == 4
                      ? Color( widget.color)
                      : Colors.grey),
                child:Text('Thailand',style: TextStyle( color: _tabController.index == 2
                    ?  Color( widget.color)
                    : Colors.grey,
                    fontSize: 16)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            KoreaMovieList(
              movieListViewModel: MovieListViewModel("Other"),
            ),
            KoreaMovieList(
              movieListViewModel: MovieListViewModel("Korea"),
            ),

            Container(
              height: 200.0,
              child: Center(child: Text('Family')),
            ),

          ],
        ),
      ),
    );
  }


}