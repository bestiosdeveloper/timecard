import 'package:flutter/material.dart';
import '../utils/constants.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      height: 400,
      color: AppColors.red[50],
      child: ListView(
        children: <Widget>[
          SizedBox(height: 50.0),
          Text(AppStrings.signIn, style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.themeBlueColor,
              fontSize: 28.0)
          ),
        ],
      ),
    );
  }
}