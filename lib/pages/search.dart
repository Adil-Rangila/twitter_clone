import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Search',
        style: myStyle(30),
      ),
    );
  }
}
