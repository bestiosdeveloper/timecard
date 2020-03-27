import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timecard/src/module/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {

  String businessUnit;
  DateTime doj;
  String email;
  String firstName;
  String lastName;
  String oracleId;
  String profilePic;
  String profileTitle;
  int themeColor;

  UserModel({
    this.businessUnit = "",
    this.doj,
    this.email = "",
    this.firstName = "",
    this.lastName = "",
    this.oracleId = "",
    this.profilePic = "",
    this.profileTitle = "",
    this.themeColor = 0
  });

  String get fullName {
    return firstName + " " + lastName;
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    businessUnit = json[FireBaseKeys.businessUnit];

    Timestamp dtSt = json[FireBaseKeys.doj];
    doj = dtSt.toDate();
    email = json[FireBaseKeys.email];
    firstName = json[FireBaseKeys.firstName];
    lastName = json[FireBaseKeys.lastName];
    oracleId = json[FireBaseKeys.oracleId];
    profilePic = json[FireBaseKeys.profilePic];
    profileTitle = json[FireBaseKeys.profileTitle];

    int tmClr = json[FireBaseKeys.themeColor];
    themeColor = tmClr;
  }

  Map<String, dynamic> toJson() =>
      {
        FireBaseKeys.businessUnit: businessUnit,
        FireBaseKeys.doj: doj,
        FireBaseKeys.email: email,
        FireBaseKeys.firstName: firstName,
        FireBaseKeys.lastName: lastName,
        FireBaseKeys.oracleId: oracleId,
        FireBaseKeys.profilePic: profilePic,
        FireBaseKeys.profileTitle: profileTitle,
        FireBaseKeys.themeColor: themeColor,
      };
}