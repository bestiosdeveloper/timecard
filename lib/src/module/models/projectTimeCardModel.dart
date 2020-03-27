import '../utils/constants.dart';

class ProjectTimeCardModel {
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

  ProjectTimeCardModel({
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

  ProjectTimeCardModel.fromJson(Map<String, dynamic> json) {

    this.pid = json[FireBaseKeys.pid];
    this.type = json[FireBaseKeys.type];
    this.location = json[FireBaseKeys.location];
    this.projectName = json[FireBaseKeys.projectName];
    this.clientName = json[FireBaseKeys.clientName];

    bool isBil = json[FireBaseKeys.isBillable];
    this.isBillable = isBil;

    double mon = json[FireBaseKeys.monday];
    this.monday = mon;

    double tue = json[FireBaseKeys.tuesday];
    this.tuesday = tue;

    double wed = json[FireBaseKeys.wednesday];
    this.wednesday = wed;

    double thu = json[FireBaseKeys.thursday];
    this.thursday = thu;

    double fri = json[FireBaseKeys.friday];
    this.friday = fri;

    double sat = json[FireBaseKeys.saturday];
    this.saturday = sat;

    double sun = json[FireBaseKeys.sunday];
    this.sunday = sun;

    this.comment = json[FireBaseKeys.comment];
  }

  Map<String, dynamic> toJson() =>
      {
        FireBaseKeys.pid: pid,
        FireBaseKeys.type: type,
        FireBaseKeys.location: location,
        FireBaseKeys.projectName: projectName,
        FireBaseKeys.clientName: clientName,
        FireBaseKeys.isBillable: isBillable,
        FireBaseKeys.monday: monday,
        FireBaseKeys.tuesday: tuesday,
        FireBaseKeys.wednesday: wednesday,
        FireBaseKeys.thursday: thursday,
        FireBaseKeys.friday: friday,
        FireBaseKeys.saturday: saturday,
        FireBaseKeys.sunday: sunday,
        FireBaseKeys.comment: comment,
      };

  double get total {
    return monday + tuesday + wednesday + thursday + friday + saturday + sunday;
  }
}