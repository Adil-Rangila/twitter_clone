import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

class TweetsPage extends StatefulWidget {
  @override
  _TweetsPageState createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Twitter',
              style: myStyle(20, Colors.white, FontWeight.w700),
            ),
            SizedBox(width: 10),
            Image.asset(
              'images/logo.png',
              scale: 6,
            ),
          ],
        ),
        actions: [
          Icon(Icons.star, size: 32),
        ],
      ),
      body: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(urlImage),
                ),
                title: Text(
                  'Adil Ahmed',
                  style: myStyle(20, Colors.black, FontWeight.w600),
                ),
                subtitle: Column(
                  children: [
                    Text(
                      'Looks like its working Profperly',
                      style: myStyle(20, Colors.black, FontWeight.w400),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.message),
                            Text('4'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.favorite_border),
                            Text('4'),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.share),
                            Text('4'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
