import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timecard/src/module/models/weekTimeCardModel.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

class HistoryViewModel {

  double defaultCardHeight = 300.0;

  WeekTimeCardModel weekData = WeekTimeCardModel();
  List<String> availableWeeks = [
    DateFormat('yyyy-MM-dd').format(DateTime.now())
  ];

  fetchDataFor(String week, ValueChanged<bool> onChanged) {
    Firestore.instance
        .collection(FireBaseKeys.weeklyTimeCard)
        .where(FireBaseKeys.weekDate, isEqualTo: week)
        .where(FireBaseKeys.owner, isEqualTo: AppConstants.currentUserId)
        .snapshots()
        .listen((result) {
      if (result.documents.isNotEmpty) {
        weekData = WeekTimeCardModel.fromJson(result.documents[0].data);
      }
      onChanged(true);
    }, onError: (error) {
      onChanged(false);
      print(error);
    });
  }
}