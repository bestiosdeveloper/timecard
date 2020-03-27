import 'projectTimeCardModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/constants.dart';
import 'package:intl/intl.dart';

class WeekTimeCardModel {
  DateTime weekDate;
  DateTime submissionDate;
  List<ProjectTimeCardModel> allTimeCards;

  WeekTimeCardModel(
      {DateTime weekDate,
      DateTime submissionDate,
      List<ProjectTimeCardModel> allTimeCards})
      : this.weekDate = weekDate ?? DateTime.now(),
        this.submissionDate = submissionDate ?? DateTime.now(),
        this.allTimeCards = allTimeCards ?? [];

  WeekTimeCardModel.fromJson(Map<String, dynamic> json) {

    weekDate = DateTime.parse(json[FireBaseKeys.weekDate].toString());

    submissionDate = DateTime.parse(json[FireBaseKeys.submissionDate].toString());

    final allTime = json[FireBaseKeys.allTimeCards];
    allTimeCards = List<ProjectTimeCardModel>();
    for (Map<String, dynamic> element in allTime) {
      allTimeCards.add(ProjectTimeCardModel.fromJson(element));
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> finalDict = {
      FireBaseKeys.weekDate: DateFormat('yyyy-MM-dd').format(weekDate),
      FireBaseKeys.submissionDate: submissionDate.toIso8601String(),
      FireBaseKeys.owner: AppConstants.currentUserId,
    };

    List<Map<String, dynamic>> temp = [];
    for (ProjectTimeCardModel element in allTimeCards) {
      temp.add(element.toJson());
    }
    finalDict.addAll({FireBaseKeys.allTimeCards: temp});

    return finalDict;
  }

  String get weekDataStr {
    return AppConstants.currentUserId + "_" + DateFormat('yyyy-MM-dd').format(weekDate);
  }

  double get total {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.total;
    }
    return value;
  }

  double get billableHours {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      if (element.isBillable) {
        value += element.total;
      }
    }
    return value;
  }

  double get nonBillableHours {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      if (!element.isBillable) {
        value += element.total;
      }
    }
    return value;
  }

  double get monday {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.monday;
    }
    return value;
  }

  double get tuesday {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.tuesday;
    }
    return value;
  }

  double get wednesday {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.wednesday;
    }
    return value;
  }

  double get thursday {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.thursday;
    }
    return value;
  }

  double get friday {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.friday;
    }
    return value;
  }

  double get saturday {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.saturday;
    }
    return value;
  }

  double get sunday {
    var value = 0.0;
    for (ProjectTimeCardModel element in allTimeCards) {
      value += element.sunday;
    }
    return value;
  }

  addNewBlankEntry() {
    allTimeCards.add(ProjectTimeCardModel());
  }
}
