import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

myStyle(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

var urlImage =
    'https://cdn.imgbin.com/2/4/15/imgbin-computer-icons-portable-network-graphics-avatar-icon-design-avatar-DsZ54Du30hTrKfxBG5PbwvzgE.jpg';

CollectionReference usercollection =
    FirebaseFirestore.instance.collection('users');

CollectionReference tweetcollection =
    FirebaseFirestore.instance.collection('tweets');
StorageReference pictures = FirebaseStorage.instance.ref().child('tweetpics');
