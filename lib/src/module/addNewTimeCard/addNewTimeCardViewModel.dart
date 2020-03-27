import 'package:flutter/material.dart';
import '../models/weekTimeCardModel.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewTimeCardViewModel {
  String message = "Please Note:"
      "\nEnsure all of your hours are accurately reflected for all external and internal projects."
      "\nT&M Projects: Billable time entered by you will be directly used for client invoicing and revenue recognition"
      "\nFT/FP Projects: All time should be marked as \"Non Billable\"";

  WeekTimeCardModel timeCardDetails = WeekTimeCardModel();
  double defaultCardHeight = 380.0;
  double grandTotalCardHeight = 120.0;
  double addNewEntryButtonHeight = 45.0;

  //validation
  bool validateCardDetails(BuildContext context) {
    if (_isIncorrectHours(timeCardDetails.monday)) {
      _showSnackBar(context, _getMessage(timeCardDetails.monday));
      return false;
    } else if (_isIncorrectHours(timeCardDetails.tuesday)) {
      _showSnackBar(context, _getMessage(timeCardDetails.tuesday));
      return false;
    } else if (_isIncorrectHours(timeCardDetails.wednesday)) {
      _showSnackBar(context, _getMessage(timeCardDetails.wednesday));
      return false;
    } else if (_isIncorrectHours(timeCardDetails.thursday)) {
      _showSnackBar(context, _getMessage(timeCardDetails.thursday));
      return false;
    } else if (_isIncorrectHours(timeCardDetails.friday)) {
      _showSnackBar(context, _getMessage(timeCardDetails.friday));
      return false;
    } else if (_isIncorrectHours(timeCardDetails.saturday)) {
      _showSnackBar(context, _getMessage(timeCardDetails.saturday));
      return false;
    } else if (_isIncorrectHours(timeCardDetails.sunday)) {
      _showSnackBar(context, _getMessage(timeCardDetails.sunday));
      return false;
    } else {
      return true;
    }
  }

  bool _isIncorrectHours(double hours) {
    if (hours > 24) {
      return true;
    } else if (hours < -24) {
      return true;
    } else {
      return false;
    }
  }

  String _getMessage(double hours) {
    final String shouldBeLess =
        "Total hours in a day should be lesser than or equal to 24";
    final String shouldBeGreat =
        "Total hours in a day should be greater than or equal to -24";
    return (hours < 0) ? shouldBeGreat : shouldBeLess;
  }

  _showSnackBar(BuildContext context, String message, {int duration = 2}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ));
  }

  saveDataToServer() {
    Map<String, dynamic> dict = timeCardDetails.toJson();

    final databaseReference = FirebaseDatabase.instance.reference();
    print(dict);

    final databaseReference1 = Firestore.instance;

    databaseReference1.collection("myData1").document("myInfo1").setData({
      'title': 'Mastering EJB',
      'description': 'Programming Guide for J2EE'
    });

    databaseReference.child("myData").child("myInfo").set({
      'title': 'Mastering EJB',
      'description': 'Programming Guide for J2EE'
    }).then((onValue) {
      print("done");
    }).catchError((onError) {
      print("fail");
      print(onError);
    });
    databaseReference.child("2").child("21").set(dict).then((onValue) {
      print("done 1");
    }).catchError((onError) {
      print("fail 1");
      print(onError);
    });
  }
}
