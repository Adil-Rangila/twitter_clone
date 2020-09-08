import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue, Colors.purple],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 2 - 64,
              top: MediaQuery.of(context).size.height / 6,
            ),
            child: CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(urlImage),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.7),
            child: Column(
              children: [
                Text(
                  'Adil',
                  style: myStyle(30, Colors.black, FontWeight.w600),
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Followers',
                      style: myStyle(20, Colors.black, FontWeight.w500),
                    ),
                    Text(
                      'Following',
                      style: myStyle(20, Colors.black, FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '500K',
                      style: myStyle(20, Colors.black, FontWeight.w500),
                    ),
                    Text(
                      '10',
                      style: myStyle(20, Colors.black, FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
