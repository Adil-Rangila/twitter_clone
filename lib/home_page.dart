import 'package:flutter/material.dart';
import 'package:twitter_clone/pages/profile.dart';
import 'package:twitter_clone/pages/search.dart';
import 'package:twitter_clone/pages/tweets.dart';
import 'package:twitter_clone/util/variables.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;

  List pageOption = [TweetsPage(), SearchPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageOption[page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            page = value;
          });
        },
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.black,
        currentIndex: page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Tweets',
              style: myStyle(20),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Search',
              style: myStyle(20),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text(
              'Profile',
              style: myStyle(20),
            ),
          ),
        ],
      ),
    );
  }
}
