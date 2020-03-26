import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'addNewTimeCardViewModel.dart';
import 'addNewTimeCardView.dart';

class SuggestedTimeCardView extends StatelessWidget {

  static double _defaultHours = 8.0;

  ProjectTimeCardItem _cardDetails = ProjectTimeCardItem(
    pid: "1234",
    type: "Project work",
    location: "Noida",
    projectName: "Accessibility Fixes",
    clientName: "US Bank",
    isBillable: true,
    monday: _defaultHours,
    tuesday: _defaultHours,
    wednesday: _defaultHours,
    thursday: _defaultHours,
    friday: _defaultHours,
    saturday: 0.0,
    sunday: 0.0,
    comment: "default comment"
  );

  final ValueChanged<ProjectTimeCardItem> onApply;

  SuggestedTimeCardView({this.onApply});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.themeBlueColor[100],
            elevation: 1,
            child: SuggestedCardDetailTile(
              _cardDetails,
              size: Size(screenWidth - 32, 300.0),
              onApply: (value) {
                onApply(_cardDetails);
              },
            ),
          ),
        ),
        SizedBox(height: 5.0),
      ],
    );
  }
}

class SuggestedCardDetailTile extends StatelessWidget {

  const SuggestedCardDetailTile(
      this.cardDetails, {
        this.size = Size.zero,
        this.onApply,
      }) : assert(
  cardDetails != null,
  );

  final ProjectTimeCardItem cardDetails;
  final Size size;
  final ValueChanged<bool> onApply;

  @override
  Widget build(BuildContext context) {
    double rowPadding = 5.0;
    double columnPadding = 10.0;
    double textFieldHeight = 40.0;

    final _titleStyle = TextStyle(
      color: AppColors.themeBlueColor[900],
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
    );

    final _redTitleStyle = TextStyle(
      color: AppColors.red,
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
    );

    final _valueStyle = TextStyle(color: AppColors.themeBlueColor[1000], fontSize: 13.0);
    final _redValueStyle = TextStyle(color: AppColors.red, fontSize: 13.0);

    return Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(
            left: rowPadding, right: rowPadding, top: rowPadding),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: AppColors.transparent,
                child: Text(
                  AppStrings.suggestedTimeCardOracle,
                  style: TextStyle(
                    color: AppColors.red[300],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.transparent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TitleValueVerticalTile(
                        title: "PID",
                        value: cardDetails.pid,
                        titleStyle: _titleStyle,
                        valueStyle: _valueStyle,
                      ),
                    ),
                    SizedBox(width: rowPadding),
                    Expanded(
                      flex: 1,
                      child: TitleValueVerticalTile(
                        title: "Project Type",
                        value: cardDetails.type,
                        titleStyle: _titleStyle,
                        valueStyle: _valueStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: columnPadding),
            Expanded(
              flex: 3,
              child: Container(
                color: AppColors.transparent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TitleValueVerticalTile(
                        title: "Project",
                        value: cardDetails.projectName,
                        titleStyle: _titleStyle,
                        valueStyle: _valueStyle,
                      ),
                    ),
                    SizedBox(width: rowPadding),
                    Expanded(
                      flex: 1,
                      child: TitleValueVerticalTile(
                        title: "Client Name",
                        value: cardDetails.clientName,
                        titleStyle: _titleStyle,
                        valueStyle: _valueStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: columnPadding),
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.monday,
                      value: cardDetails.monday.toString(),
                      titleStyle: _titleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.tuesday,
                      value: cardDetails.tuesday.toString(),
                      titleStyle: _titleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.wednesday,
                      value: cardDetails.wednesday.toString(),
                      titleStyle: _titleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.thursday,
                      value: cardDetails.thursday.toString(),
                      titleStyle: _titleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: columnPadding),
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.friday,
                      value: cardDetails.friday.toString(),
                      titleStyle: _titleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.saturday,
                      value: cardDetails.saturday.toString(),
                      titleStyle: _titleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.sunday,
                      value: cardDetails.sunday.toString(),
                      titleStyle: _titleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.total,
                      value: cardDetails.total.toString(),
                      titleStyle: _redTitleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: columnPadding),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      child: RaisedButton(
                        onPressed: () {
                          onApply(true);
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: AppColors.themeBlueColor,
                            borderRadius: BorderRadius.all(Radius.circular(80.0)),
                          ),
                          child: Container(
                            constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.apply,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: rowPadding),
          ],
        ));
  }
}