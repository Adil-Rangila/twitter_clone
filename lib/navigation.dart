import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone/signup.dart';
import 'package:twitter_clone/util/variables.dart';

import 'home_page.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool isSigned = false;

  @override
  // void initState() {
  //   FirebaseAuth.instance.authStateChanges().listen((userAccount) {
  //     if (userAccount != null) {
  //       setState(() {
  //       isSigned = true;
  //       });

  //     } else {
  //       setState(() {
  //       isSigned = false;
  //       });

  //     }
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isSigned == false ? Login() : HomePage(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var userEmail = TextEditingController();
  var userPassword = TextEditingController();

  logIN() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: userEmail.text, password: userPassword.text)
        .then((value) => print(value.user.email));
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
                'Welcom to Flutter',
                style: myStyle(30, Colors.white, FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Log In',
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
              InkWell(
                onTap: () => logIN(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Log In',
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
                    'Dont have a account? ',
                    style: myStyle(20),
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    ),
                    child: Text(
                      'Register ',
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
