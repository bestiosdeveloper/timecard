import 'package:flutter/material.dart';
import 'package:timecard/src/module/utils/constants.dart';
import '../models/weekTimeCardModel.dart';
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

  saveDataToServer(ValueChanged<bool> onComplete) {
    Map<String, dynamic> dict = timeCardDetails.toJson();

    final databaseReference1 = Firestore.instance;

    databaseReference1.collection(FireBaseKeys.weeklyTimeCard).document(timeCardDetails.weekDataStr).setData(dict).then((onValue) {
      _updateDashboardStatics();
      onComplete(true);
    }).catchError((onError) {
      onComplete(false);
    });
  }

  _updateDashboardStatics() {

    AppConstants.dashboardStatics.totalHours += timeCardDetails.total;
    AppConstants.dashboardStatics.billableHours += timeCardDetails.billableHours;
    AppConstants.dashboardStatics.nonBillableHours += timeCardDetails.nonBillableHours;

    final databaseReference1 = Firestore.instance;
    databaseReference1.collection(FireBaseKeys.dashboardStatics).document(AppConstants.dashboardStatics.documentID).setData(AppConstants.dashboardStatics.toJson()).then((onValue) {
    }).catchError((onError) {
    });
  }
}
