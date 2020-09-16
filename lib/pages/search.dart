import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/pages/viewuser.dart';
import 'package:twitter_clone/util/variables.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<QuerySnapshot> searchResult;

  searchUser(String s) {
    var users =
        usercollection.where('username', isGreaterThanOrEqualTo: s).get();
    setState(() {
      searchResult = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
            filled: true,
            hintText: 'Search For Text',
            hintStyle: myStyle(18),
          ),
          onFieldSubmitted: searchUser,
        ),
      ),
      body: searchResult == null
          ? Center(
              child: Text(
                'Search For User......',
                style: myStyle(25),
              ),
            )
          : FutureBuilder(
              future: searchResult,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot user = snapshot.data.documents[index];
                        return Card(
                          elevation: 10.0,
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(user.data()['userphoto']),
                            ),
                            title: Text(
                              user.data()['username'],
                              style: myStyle(20),
                            ),
                            trailing: MaterialButton(
                              child: Text(
                                'View',
                                style: myStyle(17, Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            ViewUser(user.data()['userid'])));
                              },
                              color: Colors.blue,
                            ),
                          ),
                        );
                      });
                }
              }),
    );
  }
}
