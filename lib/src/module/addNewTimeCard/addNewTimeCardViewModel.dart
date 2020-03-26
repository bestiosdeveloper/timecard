import 'package:flutter/material.dart';

class ProjectTimeCardItem {
  String pid = "";
  String type = "";
  String location = "";
  String projectName = "";
  String clientName = "";
  bool isBillable = false;
  double monday = 0.0;
  double tuesday = 0.0;
  double wednesday = 0.0;
  double thursday = 0.0;
  double friday = 0.0;
  double saturday = 0.0;
  double sunday = 0.0;
  String comment = "";

  ProjectTimeCardItem({
    this.pid = "",
    this.type = "",
    this.location = "",
    this.projectName = "",
    this.clientName = "",
    this.isBillable = false,
    this.monday = 0.0,
    this.tuesday = 0.0,
    this.wednesday = 0.0,
    this.thursday = 0.0,
    this.friday = 0.0,
    this.saturday = 0.0,
    this.sunday = 0.0,
    this.comment = "",
  });

  double get total {
    return monday + tuesday + wednesday + thursday + friday + saturday + sunday;
  }
}

class WeekTimeCardItem {
  DateTime weekDate = DateTime.now();
  DateTime submission = DateTime.now();
  List<ProjectTimeCardItem> allEntry = [];

  double get total {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.total;
    }
    return value;
  }

  double get monday {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.monday;
    }
    return value;
  }

  double get tuesday {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.tuesday;
    }
    return value;
  }

  double get wednesday {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.wednesday;
    }
    return value;
  }

  double get thursday {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.thursday;
    }
    return value;
  }

  double get friday {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.friday;
    }
    return value;
  }

  double get saturday {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.saturday;
    }
    return value;
  }

  double get sunday {
    var value = 0.0;
    for (ProjectTimeCardItem element in allEntry) {
      value += element.sunday;
    }
    return value;
  }

  addNewBlankEntry() {
    allEntry.add(ProjectTimeCardItem());
  }
}

class AddNewTimeCardViewModel {
  String message = "Please Note:"
      "\nEnsure all of your hours are accurately reflected for all external and internal projects."
      "\nT&M Projects: Billable time entered by you will be directly used for client invoicing and revenue recognition"
      "\nFT/FP Projects: All time should be marked as \"Non Billable\"";

  WeekTimeCardItem timeCardDetails = WeekTimeCardItem();
  double defaultCardHeight = 380.0;
  double grandTotalCardHeight = 120.0;
  double addNewEntryButtonHeight = 45.0;


  //validation
  bool validateCardDetails(BuildContext context) {

    if (_isIncorrectHours(timeCardDetails.monday)) {
      _showSnackBar(
          context, _getMessage(timeCardDetails.monday));
      return false;
    }
    else if (_isIncorrectHours(timeCardDetails.tuesday)) {
      _showSnackBar(
          context, _getMessage(timeCardDetails.tuesday));
      return false;
    }
    else if (_isIncorrectHours(timeCardDetails.wednesday)) {
      _showSnackBar(
          context, _getMessage(timeCardDetails.wednesday));
      return false;
    }
    else if (_isIncorrectHours(timeCardDetails.thursday)) {
      _showSnackBar(
          context, _getMessage(timeCardDetails.thursday));
      return false;
    }
    else if (_isIncorrectHours(timeCardDetails.friday)) {
      _showSnackBar(
          context, _getMessage(timeCardDetails.friday));
      return false;
    }
    else if (_isIncorrectHours(timeCardDetails.saturday)) {
      _showSnackBar(
          context, _getMessage(timeCardDetails.saturday));
      return false;
    }
    else if (_isIncorrectHours(timeCardDetails.sunday)) {
      _showSnackBar(
          context, _getMessage(timeCardDetails.sunday));
      return false;
    } else {
      return true;
    }
  }

  bool _isIncorrectHours(double hours) {
    if (hours > 24) {
      return true;
    }
    else if (hours < -24) {
      return true;
    }
    else {
      return false;
    }
  }
  
  String _getMessage(double hours) {
    final String shouldBeLess = "Total hours in a day should be lesser than or equal to 24";
    final String shouldBeGreat = "Total hours in a day should be greater than or equal to -24";
    return (hours < 0) ? shouldBeGreat : shouldBeLess;
  }

  _showSnackBar(BuildContext context, String message, {int duration = 2}) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ));
  }
}