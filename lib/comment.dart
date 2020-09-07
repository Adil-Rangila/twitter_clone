import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

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
    //print(userData.data()['username']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Comments',
          style: myStyle(20),
        ),
      ),
      body: ListTile(
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
    );
  }
}
