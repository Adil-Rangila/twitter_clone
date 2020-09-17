import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

import '../comment.dart';

class ViewUser extends StatefulWidget {
  final String uId;

  ViewUser(this.uId);

  @override
  _ViewUserState createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  //geting log user to authUser variable............
  var authUser = FirebaseAuth.instance.currentUser;
  // Stream userStream;
  String userName;
  String userPhoto;
  int follow;
  int following;
  bool dataShare = false;
  bool followed;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    DocumentSnapshot userData = await usercollection.doc(widget.uId).get();

    var followDocument =
        await usercollection.doc(widget.uId).collection('followers').get();

    var followingDocument =
        await usercollection.doc(widget.uId).collection('following').get();

    usercollection
        .doc(widget.uId)
        .collection('followers')
        .doc(authUser.uid)
        .get()
        .then((value) {
      if (!value.exists) {
        setState(() {
          followed = false;
        });
      } else {
        setState(() {
          followed = true;
        });
      }
    });

    setState(() {
      userName = userData.data()['username'];
      dataShare = true;
      follow = followDocument.docs.length;
      following = followingDocument.docs.length;
    });

    print(userName);
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

  likePost(String docId) async {
//fecting data from firebase to doucment variable
    DocumentSnapshot document = await tweetcollection.doc(docId).get();
    //this condition is checking that likes feild which is array has login user id or not
    if (document.data()['likes'].contains(widget.uId)) {
      //in order to add id in array we need to use fiedlvalue as following
      tweetcollection.doc(docId).update({
        'likes': FieldValue.arrayRemove([widget.uId])
      });
    } else {
      tweetcollection.doc(docId).update({
        'likes': FieldValue.arrayUnion([widget.uId])
      });
    }
  }

  followUser() async {
    //first checking the if user is already being following or not
    var userData = await usercollection
        .doc(widget.uId)
        .collection('followers')
        .doc(authUser.uid)
        .get();
//if not a follwer we add the login user uid to the viewd user
    if (!userData.exists) {
      usercollection
          .doc(widget.uId)
          .collection('followers')
          .doc(authUser.uid)
          .set({});
//same time we also add the vewuser id to auth user..becasus of follwing
      usercollection
          .doc(authUser.uid)
          .collection('following')
          .doc(widget.uId)
          .set({});

      setState(() {
        follow++;
        followed = true;
      });
    } else {
      usercollection
          .doc(widget.uId)
          .collection('followers')
          .doc(authUser.uid)
          .delete();

      usercollection
          .doc(authUser.uid)
          .collection('following')
          .doc(widget.uId)
          .delete();

      setState(() {
        follow--;
        followed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataShare == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: ScrollPhysics(),
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
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 2.7),
                    child: Column(
                      children: [
                        Text(
                          userName,
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
                              follow.toString(),
                              style: myStyle(20, Colors.black, FontWeight.w500),
                            ),
                            Text(
                              following.toString(),
                              style: myStyle(20, Colors.black, FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        InkWell(
                          onTap: () => followUser(),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue,
                            ),
                            child: Center(
                              child: Text(
                                followed == true ? 'Unfollow' : 'Follow',
                                style:
                                    myStyle(20, Colors.white, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'My Tweets',
                          style: myStyle(20, Colors.black54, FontWeight.w600),
                        ),
                        StreamBuilder(
                            //stream builder provide active dataflow and changes the ui base on database update
                            stream: tweetcollection
                                .where('userid', isEqualTo: widget.uId)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  //item count is to show the number of tweet
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    //in this part i am receinved tweet data as doucment so i can show in my app
                                    DocumentSnapshot tD =
                                        snapshot.data.documents[index];
                                    // print(tD.data());
                                    return Card(
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              tD.data()['profilephoto']),
                                        ),
                                        title: Text(
                                          tD.data()['name'],
                                          style: myStyle(20, Colors.black,
                                              FontWeight.w500),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //first type .....................
                                            if (tD.data()['type'] == 1)
                                              Text(
                                                tD.data()['tweet'],
                                                style: myStyle(20, Colors.black,
                                                    FontWeight.w300),
                                              ),
                                            //second type..........
                                            if (tD.data()['type'] == 2)
                                              Image.network(
                                                tD.data()['image'],
                                              ),
                                            //third type .................
                                            if (tD.data()['type'] == 3)
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    tD.data()['tweet'],
                                                    style: myStyle(
                                                        20,
                                                        Colors.black,
                                                        FontWeight.w300),
                                                  ),
                                                  Image.network(
                                                    tD.data()['image'],
                                                  ),
                                                ],
                                              ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () => likePost(
                                                        tD.data()['id'],
                                                      ),
                                                      child: tD
                                                              .data()['likes']
                                                              .contains(
                                                                  widget.uId)
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                          : Icon(Icons
                                                              .favorite_border),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(tD
                                                        .data()['likes']
                                                        .length
                                                        .toString()),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () =>
                                                          Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                CommentPage(
                                                                    tD.data()[
                                                                        'id'])),
                                                      ),
                                                      child:
                                                          Icon(Icons.message),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(tD
                                                        .data()['commentcount']
                                                        .toString()),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () => sharePost(
                                                          tD.data()['id'],
                                                          tD.data()['tweet']),
                                                      child: Icon(Icons.share),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(tD
                                                        .data()['shares']
                                                        .toString()),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
