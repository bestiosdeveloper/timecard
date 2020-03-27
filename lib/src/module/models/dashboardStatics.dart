import 'package:timecard/src/module/utils/constants.dart';

class DashboardStatics {
  String owner;
  String year;
  String documentID;
  double billableHours;
  double nonBillableHours;
  double totalHours;
  double benchHours;

  DashboardStatics(
      {String owner,
      String year,
      String documentID,
      double billableHours,
      double nonBillableHours,
      double totalHours,
      double benchHours})
      : this.owner = owner ?? AppConstants.currentUserId,
        this.year = year ?? DateTime.now().year.toString(),
        this.documentID = documentID ?? DateTime.now().year.toString(),
        this.billableHours = billableHours ?? 0.0,
        this.nonBillableHours = nonBillableHours ?? 0.0,
        this.totalHours = totalHours ?? 0.0,
        this.benchHours = benchHours ?? 0.0;

  double get billableUtilization {
    if (totalHours == 0.0) {
      return 0.0;
    } else {
      return (billableHours * 100) / totalHours;
    }
  }

  double get performanceUtilization {
    if (totalHours == 0.0) {
      return 0.0;
    } else {
      return (billableHours * 100) / totalHours;
    }
  }

  String get bonusImpact {
    return "NA";
  }

  DashboardStatics.fromJson(Map<String, dynamic> json) {
    owner = json[FireBaseKeys.owner];
    year = json[FireBaseKeys.year];

    billableHours = (json[FireBaseKeys.billableHours] as num).toDouble();
    nonBillableHours = (json[FireBaseKeys.nonBillableHours] as num).toDouble();
    totalHours = (json[FireBaseKeys.totalHours] as num).toDouble();
    benchHours = (json[FireBaseKeys.benchHours] as num).toDouble();
  }

  Map<String, dynamic> toJson() => {
        FireBaseKeys.owner: owner,
        FireBaseKeys.year: year,
        FireBaseKeys.billableHours: billableHours,
        FireBaseKeys.nonBillableHours: nonBillableHours,
        FireBaseKeys.totalHours: totalHours,
        FireBaseKeys.benchHours: benchHours,
      };
}
