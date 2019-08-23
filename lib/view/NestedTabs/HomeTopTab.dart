import 'package:flutter/material.dart';

import 'HomeForYourTabs.dart';
import 'HomeTopChartsTab.dart';

class HomeTopTabs extends StatefulWidget {

  HomeTopTabs(this.colorVal);
  int colorVal;

  _HomeTopTabsState createState() => _HomeTopTabsState();
}

class _HomeTopTabsState extends State<HomeTopTabs> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }
  void _handleTabSelection() {
    setState(() {
      widget.colorVal=0xffff5722;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:4,

      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorWeight: 4.0,
            indicatorColor:Color(0xffff5722),
            unselectedLabelColor: Colors.grey,
            tabs: <Widget>[
              Tab(
                icon:Icon(Icons.movie, color: _tabController.index == 0
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child:Text('Movies',style: TextStyle( color: _tabController.index == 0
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.home, color: _tabController.index == 1
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Homes',style: TextStyle( color: _tabController.index == 1
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.book, color: _tabController.index == 2
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Books',style: TextStyle( color: _tabController.index == 2
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
              Tab(
                icon: Icon(Icons.library_music, color: _tabController.index == 3
                    ? Color( widget.colorVal)
                    : Colors.grey),
                child: Text('Music',style: TextStyle( color: _tabController.index == 3
                    ?  Color( widget.colorVal)
                    : Colors.grey)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            HomeForYouTabs(),
            HomeTopChartsTabs(),
            Container(
              height: 200.0,
              child: Center(child: Text('Category')),
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