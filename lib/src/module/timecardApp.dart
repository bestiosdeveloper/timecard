import 'package:flutter/material.dart';
import 'loginPage/loginView.dart';

void main() => runApp(TimecardApp());

class TimecardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Screen",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(body: LoginView()),
    );
  }
}

