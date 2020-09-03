import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twitter_clone/util/variables.dart';

class AddTweet extends StatefulWidget {
  @override
  _AddTweetState createState() => _AddTweetState();
}

class _AddTweetState extends State<AddTweet> {
  //setting image path and selecting from camra and the gallery...............
  File imagePath;

  TextEditingController tweetController = TextEditingController();
  pickImage(ImageSource imgSource) async {
    final image = await ImagePicker().getImage(source: imgSource);
    setState(() {
      imagePath = File(image.path);
    });
    Navigator.pop(context);
  }

  optionDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () => pickImage(ImageSource.gallery),
              child: Text(
                'Image from Gallery',
                style: myStyle(20),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => pickImage(ImageSource.camera),
              child: Text(
                'Image from Camra',
                style: myStyle(20),
              ),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancil',
                style: myStyle(20),
              ),
            ),
          ],
        );
      },
    );
  }

  postTweet() async {
    //getting signed in user....
    var authUser = FirebaseAuth.instance.currentUser;
    //getting all the data of signed in user....
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(authUser.uid)
        .get();
    //this user.data is done because old method is removed.
    var userData = user.data();

    //getting lenght of tweet documents
    var allDocument =
        await FirebaseFirestore.instance.collection('tweets').get();

    var lenght = allDocument.docs.length;
    //3 condition of posting tweets..

    //only text
    if (tweetController.text != null && imagePath == null) {
      await FirebaseFirestore.instance
          .collection('tweets')
          .doc('tweet$lenght')
          .set({
        'name': userData['username'],
        'profilephoto': userData['userphoto'],
        'userid': authUser.uid,
        'id': 'tweet$lenght',
        'tweet': tweetController.text,
        'likes': [],
        'shares': 0,
        'commentcount': 0,
        'type': 1
      });
    }
    //only image
    if (tweetController.text == null && imagePath != null) {}
    //both image and text
    if (tweetController.text != null && imagePath != null) {}
  }

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
          IconButton(
              icon: Icon(
                Icons.photo,
                size: 35,
                color: Colors.white,
              ),
              onPressed: optionDialog)
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: tweetController,
              maxLines: null,
              style: myStyle(20),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Whats Happining Right Now',
                hintStyle: myStyle(25),
              ),
            ),
          ),
          //displaying image on tweet box in add tweet section.
          imagePath == null
              ? Container()
              //this condition is hiding image while keybord is shown.
              : MediaQuery.of(context).viewInsets.bottom > 0
                  ? Container()
                  : Image(
                      image: FileImage(imagePath),
                      width: 200,
                    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => postTweet(),
        child: Icon(
          Icons.publish,
          size: 32,
        ),
      ),
    );
  }
}
