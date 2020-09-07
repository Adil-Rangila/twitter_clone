import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';
import 'package:timeago/timeago.dart' as tAgo;

class CommentPage extends StatefulWidget {
  final String documentId;
  CommentPage(this.documentId);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentController = TextEditingController();

  addComment() async {
    var authUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await usercollection.doc(authUser.uid).get();

    tweetcollection.doc(widget.documentId).collection('comments').doc().set({
      'comment': _commentController.text,
      'username': userData.data()['username'],
      'userid': userData.data()['userid'],
      'profilepic': userData.data()['userphoto'],
      'time': DateTime.now()
    });

    DocumentSnapshot tweetCount =
        await tweetcollection.doc(widget.documentId).get();

    tweetcollection
        .doc(widget.documentId)
        .update({'commentcount': tweetCount.data()['commentcount'] + 1});

    _commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: tweetcollection
                        .doc(widget.documentId)
                        .collection('comments')
                        .snapshots(),
                    builder: (context, snapshot) {
                      print(snapshot);
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot userData =
                                snapshot.data.documents[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(userData.data()['profilepic']),
                              ),
                              title: Text(
                                userData.data()['username'],
                                style: myStyle(20),
                              ),
                              subtitle: Text(
                                userData.data()['comment'],
                                style: myStyle(16),
                              ),
                              trailing: Text(
                                tAgo.format(userData.data()['time'].toDate()),
                              ),
                            );
                          });
                    }),
              ),
              ListTile(
                title: TextFormField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: 'Add Comment...',
                    hintStyle: myStyle(18),
                  ),
                ),
                trailing: OutlineButton(
                  borderSide: BorderSide.none,
                  onPressed: () => addComment(),
                  child: Text(
                    'Publish',
                    style: myStyle(18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
