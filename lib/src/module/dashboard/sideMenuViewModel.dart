import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SideMenuItem {
  String title = "";
  Icon icon;
  bool isChoosen = false;
  String temp = "temp";

  SideMenuItem({this.title, this.icon, this.isChoosen});
}

class SideMenuViewModel {

  List<SideMenuItem> menuOptions = [
    SideMenuItem(title: AppStrings.home, icon: Icon(Icons.home), isChoosen: false),
    SideMenuItem(title: AppStrings.addNew, icon: Icon(Icons.create_new_folder), isChoosen: false),
    SideMenuItem(title: AppStrings.history, icon: Icon(Icons.history), isChoosen: false),
    SideMenuItem(title: AppStrings.policy, icon: Icon(Icons.note), isChoosen: false),
    SideMenuItem(title: AppStrings.vacationTracker, icon: Icon(Icons.track_changes), isChoosen: false),
    SideMenuItem(title: AppStrings.logOut, icon: Icon(Icons.exit_to_app), isChoosen: false),
  ];
}