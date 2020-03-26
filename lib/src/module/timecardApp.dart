import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'splashScreen/splashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(TimeCardApp());

class TimeCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: AppColors.themeBlueColor,
      ),
      home: Scaffold(body: SplashScreen()),
    );
  }
}

