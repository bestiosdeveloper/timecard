import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:timecard/src/module/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel {

  Map<String, Object> detailsToShow = HashMap();

  fetchDetailsToShow() {
    detailsToShow[AppStrings.oracleId] = AppConstants.currentUser.oracleId;
    detailsToShow[AppStrings.businessUnit] = AppConstants.currentUser.businessUnit;
    detailsToShow[AppStrings.email] = AppConstants.currentUser.email;

    String dojStr = DateFormat('dd MMM yyyy').format(AppConstants.currentUser.doj);
    detailsToShow[AppStrings.doj] = dojStr;
  }

  double detailRowHeight = 50.0;
  double get detailTileHeight {
    return detailsToShow.length * detailRowHeight;
  }

  updateSelectedTheme(int themeIndex, ValueChanged<bool> onComplete) {
    final databaseReference1 = Firestore.instance;

    AppConstants.currentUser.themeColor = themeIndex;

    databaseReference1.collection(FireBaseKeys.userData).document(AppConstants.currentUserId).setData(AppConstants.currentUser.toJson()).then((onValue) {
      onComplete(true);
    }).catchError((onError) {
      onComplete(false);
    });
  }
}