import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/add_tweet.dart';
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
      body: StreamBuilder(
          //stream builder provide active dataflow and changes the ui base on database update
          stream: tweetcollection.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                //item count is to show the number of tweet
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  //in this part i am receinved tweet data as doucment so i can show in my app
                  DocumentSnapshot tD = snapshot.data.documents[index];
                  // print(tD.data());
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(tD.data()['profilephoto']),
                      ),
                      title: Text(
                        tD.data()['name'],
                        style: myStyle(20, Colors.black, FontWeight.w500),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //first type .....................
                          if (tD.data()['type'] == 1)
                            Text(
                              tD.data()['tweet'],
                              style: myStyle(20, Colors.black, FontWeight.w300),
                            ),
                          //second type..........
                          if (tD.data()['type'] == 2)
                            Image.network(
                              tD.data()['image'],
                            ),
                          //third type .................
                          if (tD.data()['type'] == 3)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tD.data()['tweet'],
                                  style: myStyle(
                                      20, Colors.black, FontWeight.w300),
                                ),
                                Image.network(
                                  tD.data()['image'],
                                ),
                              ],
                            ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.favorite_border),
                                  SizedBox(width: 10),
                                  Text(tD.data()['likes'].length.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.message),
                                  SizedBox(width: 10),
                                  Text(tD.data()['commentcount'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(width: 10),
                                  Text(tD.data()['shares'].toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTweet(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 32,
        ),
      ),
    );
  }
}
