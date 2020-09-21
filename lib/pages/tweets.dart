import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/add_tweet.dart';
import 'package:twitter_clone/comment.dart';
import 'package:twitter_clone/util/variables.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';

class TweetsPage extends StatefulWidget {
  @override
  _TweetsPageState createState() => _TweetsPageState();
}

class _TweetsPageState extends State<TweetsPage> {
  //geting log user to authUser variable............
  var authUser = FirebaseAuth.instance.currentUser;
  final FirebaseMessaging tok = FirebaseMessaging();

  likePost(String docId, String uID) async {
//fecting data from firebase to doucment variable
    DocumentSnapshot document = await tweetcollection.doc(docId).get();
    //this condition is checking that likes feild which is array has login user id or not
    if (document.data()['likes'].contains(authUser.uid)) {
      //in order to add id in array we need to use fiedlvalue as following
      tweetcollection.doc(docId).update({
        'likes': FieldValue.arrayRemove([authUser.uid])
      });
    } else {
      tweetcollection.doc(docId).update({
        'likes': FieldValue.arrayUnion([authUser.uid])
      });

      FirebaseFirestore.instance
          .collection('users')
          .doc(uID)
          .get()
          .then((snapshot) {
        FirebaseFirestore.instance.collection('notifications').add({
          'senderid': authUser.uid,
          'sendername': authUser.email,
          'recevierDevices': snapshot.data()['token']
        });
      });
    }
  }

//this method is used to share the documents/tweets.....
  sharePost(String documentID, String documentTweet) async {
    //this one used to share the just plain text.............
    Share.text('Tweeter Clone', documentTweet, 'text/plain');
    //this one is done so i can count the number of shares.....
    DocumentSnapshot document = await tweetcollection.doc(documentID).get();
    tweetcollection.doc(documentID).update(
      {'shares': document.data()['shares'] + 1},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.white,
            ),
            onPressed: () async {
              await tok.getToken().then((token) => {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(authUser.uid)
                        .update({
                      'token': FieldValue.arrayRemove([token])
                    })
                  });

              FirebaseAuth.instance.signOut();
            }),
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
              return Center(child: CircularProgressIndicator());
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
                                  InkWell(
                                    onTap: () => likePost(
                                        tD.data()['id'], tD.data()['userid']),
                                    child: tD
                                            .data()['likes']
                                            .contains(authUser.uid)
                                        ? Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : Icon(Icons.favorite_border),
                                  ),
                                  SizedBox(width: 10),
                                  Text(tD.data()['likes'].length.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommentPage(tD.data()['id'])),
                                    ),
                                    child: Icon(Icons.message),
                                  ),
                                  SizedBox(width: 10),
                                  Text(tD.data()['commentcount'].toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () => sharePost(
                                        tD.data()['id'], tD.data()['tweet']),
                                    child: Icon(Icons.share),
                                  ),
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
