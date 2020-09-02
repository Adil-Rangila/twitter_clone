import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

class AddTweet extends StatefulWidget {
  @override
  _AddTweetState createState() => _AddTweetState();
}

class _AddTweetState extends State<AddTweet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 32,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Tweet',
          style: myStyle(23),
        ),
        actions: [
          Icon(
            Icons.photo,
            size: 35,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              maxLines: null,
              style: myStyle(20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Whats Happining Right Now',
                hintStyle: myStyle(25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
