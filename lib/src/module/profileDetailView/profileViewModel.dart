import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:timecard/src/module/utils/constants.dart';

class ProfileViewModel {

  Map<String, Object> detailsToShow = HashMap();

  fetchDetailsToShow() {
    detailsToShow[AppStrings.oracleId] = AppConstants.currentUser.oracleId;
    detailsToShow[AppStrings.businessUnit] = AppConstants.currentUser.businessUnit;
    detailsToShow[AppStrings.email] = AppConstants.currentUser.email;

    String dojStr = DateFormat('dd MMM yyyy').format(AppConstants.currentUser.doj);
    detailsToShow[AppStrings.doj] = dojStr;

    print("Fetched");
  }

  double detailRowHeight = 50.0;
  double get detailTileHeight {
    return detailsToShow.length * detailRowHeight;
  }
}