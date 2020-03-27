import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../profileDetailView/profileDetailView.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SideMenuItem {
  String title = "";
  Icon icon;
  bool isChosen = false;
  String temp = "temp";

  SideMenuItem({this.title, this.icon, this.isChosen});
}

class SideMenuViewModel {

  List<SideMenuItem> menuOptions = [
    SideMenuItem(title: AppStrings.home, icon: Icon(Icons.home), isChosen: false),
    SideMenuItem(title: AppStrings.addNew, icon: Icon(Icons.create_new_folder), isChosen: false),
    SideMenuItem(title: AppStrings.history, icon: Icon(Icons.history), isChosen: false),
    SideMenuItem(title: AppStrings.policy, icon: Icon(Icons.note), isChosen: false),
//    SideMenuItem(title: AppStrings.vacationTracker, icon: Icon(Icons.track_changes), isChosen: false),
    SideMenuItem(title: AppStrings.logOut, icon: Icon(Icons.exit_to_app), isChosen: false),
  ];

  goToProfileDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileDetailView()),
    );
  }

  addListnerForThemeUpdate(ValueChanged<bool> onComplete) {

    Firestore.instance
        .collection(FireBaseKeys.userData)
        .snapshots()
        .listen((result) {
          onComplete(true);
    }, onError: (error) {
      onComplete(false);
    });
  }
}