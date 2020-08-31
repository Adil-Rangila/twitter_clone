import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'util/variables.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var userEmail = TextEditingController();
  var userPassword = TextEditingController();
  var userName = TextEditingController();

  register() {
    //before .then is part where auth is saveing in authicantion.....other part is saving in cloud firestore
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: userEmail.text, password: userPassword.text)
        .then((signdUser) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(signdUser.user.uid)
          .set({
        'userid': signdUser.user.uid,
        'username': userName.text,
        'useremail': userEmail.text,
        'userpassword': userPassword.text,
        'userphoto':
            'https://w0.pngwave.com/png/639/452/computer-icons-avatar-user-profile-people-icon-png-clip-art.png'
      });

      //  print('hello : ' + signdUser.user.email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Started With Flutter',
                style: myStyle(30, Colors.white, FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Sign Up',
                style: myStyle(25, Colors.white, FontWeight.w600),
              ),
              SizedBox(height: 20),
              //logo image in login page................................................
              Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  'images/logo.png',
                ),
              ),
              //email address field....................................................
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: TextField(
                  controller: userEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                    labelStyle: myStyle(15),
                  ),
                ),
              ),
              //password field....................................................
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: TextField(
                  controller: userPassword,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                    labelStyle: myStyle(15),
                  ),
                ),
              ),

              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width - 30,
                child: TextField(
                  controller: userName,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'User Name',
                    labelStyle: myStyle(15),
                  ),
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () => register(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Sign Up',
                      style: myStyle(18, Colors.black, FontWeight.w700),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I agree to ',
                    style: myStyle(20),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    ),
                    child: Text(
                      'Privicy & Policy ',
                      style: myStyle(20, Colors.white, FontWeight.w600),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
