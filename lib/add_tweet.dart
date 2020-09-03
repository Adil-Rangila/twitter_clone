import 'dart:io';

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
    );
  }
}
