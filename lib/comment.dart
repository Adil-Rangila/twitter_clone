import 'package:flutter/material.dart';
import 'package:twitter_clone/util/variables.dart';

class CommentPage extends StatefulWidget {
  final String documentId;
  CommentPage(this.documentId);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
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
      body: Center(
        child: Text(widget.documentId),
      ),
    );
  }
}
