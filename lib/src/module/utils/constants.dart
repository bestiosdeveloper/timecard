import 'package:flutter/material.dart';
import '../models/userModel.dart';
import '../models/dashboardStatics.dart';

//App used colors
class AppColors {

  static const List<Color> themeColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.purple,
    Colors.pink,
    Colors.amber,
  ];

  static get themeBlueColor {
    if (AppConstants.currentUser == null) {
      return themeColors[0];
    } else {
      return themeColors[AppConstants.currentUser.themeColor];
    }
  }

  static const themeWhiteColor = Colors.white;
  static const white = Colors.white;
  static const black = Colors.black;
  static const gray = Colors.black54;
  static const lightGray = Colors.black38;
  static const red = Colors.red;
  static const green = Colors.green;
  static const transparent = Colors.transparent;

  static get selected {
    return themeBlueColor;
  }

  static get deselected {
    return themeBlueColor;
  }
}

//useful variables
class AppConstants {

  static UserModel currentUser;
  static DashboardStatics dashboardStatics;

  static const String appName = "Time Tracker";
  static var lastSelectedSideMenu = 0;
  static const int minCredentialLength = 3;
  static const double homeMenuContainerHeight = 44.0;

  static var currentUserId = "";
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

  //Home Screen
  static const String welcome = "Welcome, ";


  //Days
  static const String monday = "Monday";
  static const String tuesday = "Tuesday";
  static const String wednesday = "Wednesday";
  static const String thursday = "Thursday";
  static const String friday = "Friday";
  static const String saturday = "Saturday";
  static const String sunday = "Sunday";

  static const String total = "Total";
  static const String pid = "PID";
  static const String projectType = "Project Type";
  static const String type = "Type";
  static const String project = "Project";
  static const String clientName = "Client Name";
  static const String apply = "Apply";
  static const String comment = "Comment";
  static const String location = "Location";
  static const String suggestedTimeCardOracle = "Suggested Time Card based on oracle";

  //Profile Details
  static const String myProfileTitle = "'s Profile";
  static const String oracleId = "Oracle ID";
  static const String email = "Email-ID";
  static const String businessUnit = "Business Unit";
  static const String doj = "Start Date";

}

//App used messages
class AppMessages {
  static const String llIdRequired = "Your access requires your Lion Login (LL) ID \nPlease DO NOT USE your email address";
  static const String issueInLogin = "Facing issue in login? \nRaise a helpdesk ticket.";
  static const String enterYourLlId = "Sorry, requested LL ID is unavailable.";
  static const String llIdIsShort = "Sorry, LL ID is too short.";
  static const String enterPassword = "Sorry, requested password is unavailable.";
  static const String passwordIsShort = "Sorry, password is too short.";
  static const String useIdOrPasswordIncorrect = "Sorry, either LL Id or password are incorrect.";
  static const String idPasswordCanNotSame = "Password can not be same as LL ID.";
}

//Keys used in SharedPreferences
class SharedPreferencesKeys {
  static const String loggedInUserId = "loggedInUserId";
  static const String themeColorIndex = "themeColorIndex";
}

class FireBaseKeys {

  //RegisteredUser
  static const String registeredUser = "registeredUser";
  static const String userName = "userName";
  static const String userId = "userId";
  static const String password = "password";

  //UserDetails
  static const String userData = "userData";
  static const String businessUnit = "businessUnit";
  static const String doj = "doj";
  static const String email = "email";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String oracleId = "oracleId";
  static const String profilePic = "profilePic";
  static const String profileTitle = "profileTitle";
  static const String themeColor = "themeColor";

  //Project Time Card
  static const String pid = "pid";
  static const String type = "type";
  static const String location = "location";
  static const String projectName = "projectName";
  static const String clientName = "clientName";
  static const String isBillable = "isBillable";
  static const String monday = "monday";
  static const String tuesday = "tuesday";
  static const String wednesday = "wednesday";
  static const String thursday = "thursday";
  static const String friday = "friday";
  static const String saturday = "saturday";
  static const String sunday = "sunday";
  static const String comment = "comment";

  //Week Time Card
  static const String weeklyTimeCard = "weeklyTimeCard";
  static const String weekDate = "weekDate";
  static const String submissionDate = "submissionDate";
  static const String allTimeCards = "allTimeCards";
  static const String owner = "owner";

  //Dashboard Statics
  static const String dashboardStatics = "dashboardStatics";
  static const String billableHours = "billableHours";
  static const String nonBillableHours = "nonBillableHours";
  static const String totalHours = "totalHours";
  static const String benchHours = "benchHours";
  static const String year = "year";
}