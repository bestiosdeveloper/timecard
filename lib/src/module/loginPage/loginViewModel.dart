import 'package:flutter/material.dart';
import '../dashboard/dashboardView.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel {

  String llId = "";
  String password = "";

  setLlId(String llId) {
    this.llId = llId;
  }

  setPassword(String password) {
    this.password = password;
  }

  signInWithVerification(BuildContext context) async{
    if (_isDataValid(context)) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(SharedPreferencesKeys.isLoggedIn, true);
      _goToDashboard(context);
    }
  }

  bool _isDataValid(BuildContext context) {
    if (this.llId.isEmpty) {
      _showSnackBar(context, AppMessages.enterYourLlId);
      return false;
    }
    else if (this.llId.length < AppConstants.minCredentialLength) {
      _showSnackBar(context, AppMessages.llIdIsShort);
      return false;
    }
    else if (this.password.isEmpty) {
      _showSnackBar(context, AppMessages.enterPassword);
      return false;
    }
    else if (this.password.length < AppConstants.minCredentialLength) {
      _showSnackBar(context, AppMessages.passwordIsShort);
      return false;
    }
    else if (this.password == this.llId) {
      _showSnackBar(context, AppMessages.idPasswordCanNotSame);
      return false;
    }
    else {
      return true;
    }
  }

  _goToDashboard(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardView()),
    );
  }

  _showSnackBar(BuildContext context, String message, {int duration = 1}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ));
  }
}