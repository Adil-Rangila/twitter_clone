import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Profile',
        style: myStyle(30),
      ),
    );
  }
}
