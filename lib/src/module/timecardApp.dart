import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'splashScreen/splashScreen.dart';

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

