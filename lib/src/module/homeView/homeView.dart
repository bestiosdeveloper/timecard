import 'package:flutter/material.dart';
import 'package:timecard/presentation/custom_icons_icons.dart';
import '../utils/constants.dart';
import 'homeViewModel.dart';


class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends  State<HomeView> {
  HomeViewModel viewModel = HomeViewModel();
  String currentSelectedYear = "";
  bool shouldUpdate = false;

  @override
  void initState() {
    super.initState();

    currentSelectedYear = DateTime.now().year.toString();
    _callFetchDashboard();
  }

  _callFetchDashboard() {
    viewModel.fetchDashboardStatics(currentSelectedYear, (isDone){
      setState(() {
        shouldUpdate = true;
      });
    });
  }

  Widget _getHeaderWidget() {
    return Column(
      children: <Widget>[
        SizedBox(height: 0.0),
        Text(AppStrings.welcome + AppConstants.currentUser.firstName,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.themeBlueColor[900],
                fontSize: 22.0)),
        Text("Your Time Card",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.themeBlueColor[900],
                fontSize: 18.0)),
        Column(
          children: <Widget>[
            SizedBox(height: 40.0),
            Text("Your utilization and bench hours for the year ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                    fontSize: 15.0)),
            SizedBox(height: 10.0),
            _getYearsPopupMenu(),
          ],
        ),
      ],
    );
  }

  List<PopupMenuItem<String>> _getYearsPopupMenuItems() {
    return viewModel.availableYears.map((item) {
      return PopupMenuItem<String>(
          child: Text(item),
          value: item
      );
    }).toList();
  }

  Widget _getYearsPopupMenu() {
    return PopupMenuButton(
        itemBuilder: (_) => _getYearsPopupMenuItems(),
        child: OutlineButton(
            disabledBorderColor: AppColors.lightGray,
            splashColor: AppColors.themeBlueColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            child: Text(currentSelectedYear + " ▼",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeBlueColor[700],
                    fontSize: 15.0)
            ),
        ),
        onSelected: (String result) {
          setState(() {
            this.currentSelectedYear = result;
            _callFetchDashboard();
          });
        });
  }

  Widget _getImpactWidget() {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: viewModel.impactAreas.length,
        itemBuilder: (context, index) {
          return TitleValueHorizontalTile(
            title: viewModel.impactAreas[index].title,
            value: viewModel.impactAreas[index].value,
            height: viewModel.impactRowHeight,
          );
        });
  }

  Widget _getBulletWidget() {
    double iconSize = viewModel.bulletRowHeight * 0.32;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemExtent: viewModel.bulletRowHeight,
        itemCount: viewModel.bulletPoints.length,
        itemBuilder: (context, index) {
          bool isBullet = viewModel.bulletPoints[index].isBullet;
          return ListTile(
            leading: isBullet ? Icon(CustomIcons.fiber_manual_record, size: iconSize, color: AppColors.themeBlueColor) : null,
            title: Text(
              viewModel.bulletPoints[index].title,
              style: TextStyle(
                fontWeight: isBullet ? FontWeight.normal : FontWeight.bold,
                fontSize: isBullet ? 14 : 16,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: screenHeight -
          (statusBarHeight + AppConstants.homeMenuContainerHeight),
      child: ListView(
        children: <Widget>[
          _getHeaderWidget(),
          SizedBox(height: 20.0),
          Container(
            height: viewModel.impactTileHeight + 30,
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: AppColors.themeBlueColor[200],
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 20),
                child: _getImpactWidget(),
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: viewModel.bulletTileHeight,
            child: _getBulletWidget(),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}

class TitleValueHorizontalTile extends StatelessWidget {
  String title = "";
  String value = "";
  double height = 0.0;

  TitleValueHorizontalTile({this.title = "", this.value = "", this.height = 40.0});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: height),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  value,
                  style: TextStyle(color: AppColors.black, fontSize: 15.0),
                ),
                alignment: Alignment.centerRight,
              ),
            )
          ],
        ),
      ),
    );
  }
}
