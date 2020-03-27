import 'package:flutter/material.dart';
import '../dashboard/dashboardView.dart';
import '../utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/userModel.dart';

class LoginViewModel {
  String llId = "";
  String password = "";

  setLlId(String llId) {
    this.llId = llId;
  }

  setPassword(String password) {
    this.password = password;
  }

  signInWithVerification(BuildContext context) async {
    if (_isDataValid(context)) {
      _loginUser(context);
    }
  }

  bool _isDataValid(BuildContext context) {
    if (this.llId.isEmpty) {
      _showSnackBar(context, AppMessages.enterYourLlId);
      return false;
    } else if (this.llId.length < AppConstants.minCredentialLength) {
      _showSnackBar(context, AppMessages.llIdIsShort);
      return false;
    } else if (this.password.isEmpty) {
      _showSnackBar(context, AppMessages.enterPassword);
      return false;
    } else if (this.password.length < AppConstants.minCredentialLength) {
      _showSnackBar(context, AppMessages.passwordIsShort);
      return false;
    } else if (this.password == this.llId) {
      _showSnackBar(context, AppMessages.idPasswordCanNotSame);
      return false;
    } else {
      return true;
    }
  }

  _loginUser(BuildContext context) {
    print("1");
    Firestore.instance
        .collection(FireBaseKeys.registeredUser)
        .where(FireBaseKeys.userName, isEqualTo: this.llId)
        .where(FireBaseKeys.password, isEqualTo: this.password)
        .snapshots()
        .listen((result) {
      if (result.documents.isEmpty) {
        _showSnackBar(context, AppMessages.useIdOrPasswordIncorrect);
      } else {
        String userId = result.documents[0][FireBaseKeys.userId];
        _fetchUserDetailsAndGoDashboard(context, userId);
      }
    }, onError: (error) {
      print(error);
    });
  }

  _saveInPreference(String id) async {
    print("2 " + id);
    AppConstants.currentUserId = id;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(SharedPreferencesKeys.loggedInUserId, id);
  }

  _fetchUserDetailsAndGoDashboard(BuildContext context, String userId) {
    _saveInPreference(userId);
    Firestore.instance
        .collection(FireBaseKeys.userData)
        .document(userId)
        .get()
        .then((result) {
      _saveCurrentUserData(result.data);
      _goToDashboard(context);
    });
  }

  _saveCurrentUserData(Map<String, dynamic> data) {
    print("3");
    AppConstants.currentUser = UserModel.fromJson(data);
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
