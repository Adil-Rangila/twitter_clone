import 'package:flutter/material.dart';

import 'home_page.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  bool isSigned = false;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ],
        ),
      ),
    );
  }
}
