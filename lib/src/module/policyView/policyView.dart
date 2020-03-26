import 'package:flutter/material.dart';
import 'package:timecard/presentation/custom_icons_icons.dart';
import '../utils/constants.dart';
import 'policyViewModel.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class PolicyView extends StatelessWidget {
  PolicyViewModel viewModel = PolicyViewModel();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      height: screenHeight -
          (statusBarHeight + AppConstants.homeMenuContainerHeight),
      child: ListView(
        children: _getAllData(),
      ),
    );
  }

  List<Widget> _getAllData() {
    List<Widget> temp = [
      _getHeaderWidget(),
      SizedBox(height: 20.0),
      Container(
        height: viewModel.bulletTileHeight,
        child: _getBulletWidget(),
      ),
      SizedBox(height: 20.0),
    ];

    for (var i = 0; i < viewModel.questions.length; i++) {
      temp.add(_getQuestionsCollapsibleTile(i));
    }

    return temp;
  }

  Widget _getHeaderWidget() {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(viewModel.message,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                      fontSize: 14.0)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getBulletWidget() {
    double iconSize = 15;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: viewModel.bulletPoints.length,
        itemBuilder: (context, index) {
          bool isBullet = viewModel.bulletPoints[index].isBullet;
          return ListTile(
            leading: isBullet ? Icon(CustomIcons.fiber_manual_record, size: iconSize, color: AppColors.themeBlueColor) : null,
            title: Text(
              viewModel.bulletPoints[index].title,
              style: TextStyle(
                color: isBullet ? AppColors.black : AppColors.themeBlueColor[900],
                fontWeight: isBullet ? FontWeight.normal : FontWeight.bold,
                fontSize: isBullet ? 14 : 16,
              ),
            ),
          );
        });
  }

  Widget _getQuestionsCollapsibleTile(int index) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      child: ExpandablePanel(
        theme: ExpandableThemeData(
          headerAlignment: ExpandablePanelHeaderAlignment.center,
          hasIcon: true,
          iconColor: AppColors.themeBlueColor,
          iconPlacement: ExpandablePanelIconPlacement.left,
          bodyAlignment: ExpandablePanelBodyAlignment.right,
        ),
        header: Container(
          padding: EdgeInsets.all(5.0),
            child: Text(
              viewModel.questions[index].question,
              style: TextStyle(
                color: AppColors.themeBlueColor,
                fontWeight: FontWeight.w500,
              ),
            )
        ),
        expanded: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 10),
          child: HtmlView(
            data: viewModel.questions[index].ans,
            scrollable: false,
          ),
        ),
      ),
    );
  }
}