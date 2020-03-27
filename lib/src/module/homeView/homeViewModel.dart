import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:timecard/src/module/models/dashboardStatics.dart';
import '../utils/constants.dart';

class TitleValueItem {
  String title = "";
  String value = "";

  TitleValueItem({this.title = "", this.value = ""});
}

class BulletPointItem {
  String title = "";
  bool isBullet = true;

  BulletPointItem({this.title = "", this.isBullet = true});
}

class HomeViewModelInterface {

}

class HomeViewModel {

  List<TitleValueItem> impactAreas = [];

  List<BulletPointItem> bulletPoints = [
    BulletPointItem(title: "In general, the time card policy states:", isBullet: false),
    BulletPointItem(title: "Submit your own time card each week.", isBullet: true),
    BulletPointItem(title: "Time cards are required by all Publicis Sapient people and contractors.*", isBullet: true),
    BulletPointItem(title: "Time cards are due every Monday at 12 pm Pacific Time (3 pm Eastern Time).", isBullet: true),
    BulletPointItem(title: "When taking vacation, you must submit your time card(s) before you leave.", isBullet: true),
    BulletPointItem(title: "Violations for submissions and approvals are tracked and counted separately", isBullet: true),
    BulletPointItem(title: "The first 5 late time card submissions will be tracked but will not elicit a penalty.", isBullet: true),
    BulletPointItem(title: "The first 5 late approvals will be tracked but will not elicit a penalty.", isBullet: true),
  ];

  double impactRowHeight = 40.0;
  double get impactTileHeight {
    return impactAreas.length * impactRowHeight;
  }

  double bulletRowHeight = 60.0;
  double get bulletTileHeight {
    return bulletPoints.length * bulletRowHeight;
  }

  List<String> availableYears = [
    "2019",
    "2020",
  ];

  _calculateImpactAreas() {
    impactAreas = [
      TitleValueItem(title: "Billable Utilization", value: AppConstants.dashboardStatics.billableUtilization.toStringAsFixed(2) + "%"),
      TitleValueItem(title: "Performance Utilization", value: AppConstants.dashboardStatics.performanceUtilization.toStringAsFixed(2) + "%"),
      TitleValueItem(title: "Bench Hours", value: AppConstants.dashboardStatics.benchHours.toStringAsFixed(1)),
      TitleValueItem(title: "Bonus Impact due to Bench Hours", value: AppConstants.dashboardStatics.bonusImpact),
    ];
  }

  fetchDashboardStatics(String year, ValueChanged<bool> onChanged) {
    Firestore.instance
        .collection(FireBaseKeys.dashboardStatics)
        .where(FireBaseKeys.owner, isEqualTo: AppConstants.currentUserId)
        .where(FireBaseKeys.year, isEqualTo: year)
        .snapshots()
        .listen((result) {
      if (result.documents.isEmpty) {
        AppConstants.dashboardStatics = DashboardStatics(owner: AppConstants.currentUserId);
      } else {
        DashboardStatics dash = DashboardStatics.fromJson(result.documents[0].data);
        dash.documentID = result.documents[0].documentID;
        AppConstants.dashboardStatics = dash;
      }
      _calculateImpactAreas();
      onChanged(true);
    }, onError: (error) {
      print(error);
      onChanged(false);
    });
  }
}