import 'package:flutter/material.dart';

//App used colors
class AppColors {
  static const themeBlueColor = Colors.green;
  static const themeWhiteColor = Colors.white;
  static const white = Colors.white;
  static const black = Colors.black;
  static const gray = Colors.black54;
  static const red = Colors.red;

  static const selected = themeBlueColor;
  static const deselected = themeBlueColor;
}

//useful variables
class AppConstants {
  static const String appName = "Time Tracker";
  static var lastSelectedSideMenu = 0;
  static const int minCredentialLength = 3;
  static const double homeMenuContainerHeight = 44.0;
}

//App used strings
class AppStrings {

  //splash
  static const String splashQuote = "Time isn't the main thing, \nIt's the only thing.";

  //Login Screen
  static const String signIn = "Sign In";
  static const String lioLogin = "Lion Login (LL) ID";
  static const String password = "Password";

  //Side Menu
  static const String home = "Home";
  static const String addNew = "Add New";
  static const String history = "History";
  static const String policy = "Policy";
  static const String vacationTracker = "Vacation Tracker";
  static const String logOut = "Logout";

  //temp images
  static const String profileImage = "https://scontent-frx5-1.xx.fbcdn.net/v/t1.0-9/82570271_3380634742010578_3932587702507012096_n.jpg?_nc_cat=111&_nc_sid=85a577&_nc_ohc=YtbgNfiph-8AX-QfpRL&_nc_ht=scontent-frx5-1.xx&oh=ec1409ec45ff312fcea91272443fd812&oe=5E98B978";
}

//App used messages
class AppMessages {
  static const String llIdRequired = "Your access requires your Lion Login (LL) ID \nPlease DO NOT USE your email address";
  static const String issueInLogin = "Facing issue in login? \nRaise a helpdesk ticket.";
  static const String enterYourLlId = "Sorry, requested LL ID is unavailable.";
  static const String llIdIsShort = "Sorry, LL ID is too short.";
  static const String enterPassword = "Sorry, requested password is unavailable.";
  static const String passwordIsShort = "Sorry, password is too short.";
  static const String idPasswordCanNotSame = "Password can not be same as LL ID.";
}

//Keys used in SharedPreferences
class SharedPreferencesKeys {
  static const String isLoggedIn = "isLoggedIn";
}