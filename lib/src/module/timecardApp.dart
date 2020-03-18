import 'package:flutter/material.dart';
import 'loginPage/loginView.dart';
import 'utils/constants.dart';

void main() => runApp(TimeCardApp());

class TimeCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Screen",
      theme: ThemeData(
        primarySwatch: AppColors.themeBlueColor,
      ),
      home: Scaffold(body: LoginView()),
    );
  }
}

