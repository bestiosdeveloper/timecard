import 'package:flutter/material.dart';
import '../dashboard/homeView.dart';
import '../utils/constants.dart';

class LoginViewModel {

  String llId = "";
  String password = "";

  setLlId(String llId) {
    this.llId = llId;
  }

  setPassword(String password) {
    this.password = password;
  }

  signInWithVerification(BuildContext context) {
    if (isDataValid(context)) {
      goToDashboard(context);
    }
  }

  bool isDataValid(BuildContext context) {
    if (this.llId.isEmpty) {
      showSnackBar(context, AppMessages.enterYourLlId);
      return false;
    }
    else if (this.password.isEmpty) {
      showSnackBar(context, AppMessages.enterPassword);
      return false;
    }
    else {
      return true;
    }
  }

  goToDashboard(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }

  showSnackBar(BuildContext context, String message, {int duration = 1}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ));
  }
}