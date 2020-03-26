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
    "2017",
    "2018",
    "2019",
    "2020",
  ];

  fetchDataFor(String year) {
    int yr = int.parse(year);
    double ut = (yr * 0.02);
    double hr = (yr * 0.03);
    impactAreas = [
      TitleValueItem(title: "Billable Utilization", value: ut.toString() + "%"),
      TitleValueItem(title: "Performance Utilization", value: ut.toString() + "%"),
      TitleValueItem(title: "Bench Hours", value: hr.toString()),
      TitleValueItem(title: "Bonus Impact due to Bench Hours", value: "NA"),
    ];
  }
}