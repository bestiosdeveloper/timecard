import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timecard/src/module/historyView/historyViewModel.dart';
import '../utils/constants.dart';
import '../models/projectTimeCardModel.dart';
import '../addNewTimeCard/addNewTimeCardView.dart';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  HistoryViewModel viewModel = HistoryViewModel();
  bool shouldUpdate = false;
  String currentSelectedWeek = "";

  @override
  void initState() {
    super.initState();
    currentSelectedWeek = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _callWeekTimeCardAPI();
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
          _getTimeCardWidget(),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  _callWeekTimeCardAPI() {
    viewModel.fetchDataFor(currentSelectedWeek, (isDone) {
      setState(() {
        shouldUpdate = true;
      });
    });
  }

  Widget _getHeaderWidget() {
    return Column(
      children: <Widget>[
        Text("Your time card details for week: ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.black,
                fontSize: 15.0)),
        SizedBox(height: 10.0),
        _getWeekPopupMenu(),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _getTimeCardWidget() {
    double timeCardsHeight = (viewModel.weekData.allTimeCards.length *
        (viewModel.defaultCardHeight));
    double totalHeight = timeCardsHeight + 10.0;

    return Container(
      height: totalHeight,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.themeBlueColor[50],
        elevation: 3,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: viewModel.weekData.allTimeCards.length,
            itemBuilder: (context, index) {
              return _getCardDetailTile(index);
            }),
      ),
    );
  }

  Widget _getCardDetailTile(int index) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Container(
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.themeBlueColor[100],
            elevation: 1,
            child: CardTextDetailTile(
              viewModel.weekData.allTimeCards[index],
              size: Size(screenWidth - 32, viewModel.defaultCardHeight),
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  List<PopupMenuItem<String>> _getWeekPopupMenuItems() {
    return viewModel.availableWeeks.map((item) {
      return PopupMenuItem<String>(child: Text(item), value: item);
    }).toList();
  }

  Widget _getWeekPopupMenu() {
    return PopupMenuButton(
        itemBuilder: (_) => _getWeekPopupMenuItems(),
        child: OutlineButton(
          disabledBorderColor: AppColors.lightGray,
          splashColor: AppColors.themeBlueColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Text(currentSelectedWeek + " ▼",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.themeBlueColor[700],
                  fontSize: 15.0)),
        ),
        onSelected: (String result) {
          setState(() {
            this.currentSelectedWeek = result;
            _callWeekTimeCardAPI();
          });
        });
  }
}

class CardTextDetailTile extends StatelessWidget {
  const CardTextDetailTile(
    this.cardDetails, {
    this.size = Size.zero,
  }) : assert(
          cardDetails != null,
        );

  final ProjectTimeCardModel cardDetails;
  final Size size;

  @override
  Widget build(BuildContext context) {
    double rowPadding = 5.0;
    double columnPadding = 10.0;

    TextStyle _titleStyle = TextStyle(
      color: AppColors.themeBlueColor[900],
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
    );

    TextStyle _valueStyle = TextStyle(color: AppColors.black, fontSize: 13.0);

    TextStyle _redTitleStyle = TextStyle(
      color: AppColors.red,
      fontSize: 15.0,
      fontWeight: FontWeight.w700,
    );

    TextStyle _redValueStyle = TextStyle(color: AppColors.red, fontSize: 13.0);

    return Container(
      height: size.height,
      width: size.width,
      padding: EdgeInsets.only(left: rowPadding, right: rowPadding, top: rowPadding),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              color: AppColors.transparent,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: TitleValueVerticalTile(
                      title: AppStrings.pid,
                      value: cardDetails.pid,
                      titleStyle: _titleStyle,
                      valueStyle: _valueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 4,
                    child: TitleValueVerticalTile(
                      title: AppStrings.type,
                      value: cardDetails.type,
                      titleStyle: _titleStyle,
                      valueStyle: _valueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 4,
                    child: TitleValueVerticalTile(
                      title: AppStrings.location,
                      value: cardDetails.location,
                      titleStyle: _titleStyle,
                      valueStyle: _valueStyle,
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 2,
                    child: CheckboxTile(
                      title: "Billable?",
                      isSelected: cardDetails.isBillable,
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
                    valueStyle: _valueStyle,
                  ),
                ),
                SizedBox(width: rowPadding),
                Expanded(
                  flex: 1,
                  child: TitleValueVerticalTile(
                    title: AppStrings.tuesday,
                    value: cardDetails.tuesday.toString(),
                    titleStyle: _titleStyle,
                    valueStyle: _valueStyle,
                  ),
                ),
                SizedBox(width: rowPadding),
                Expanded(
                  flex: 1,
                  child: TitleValueVerticalTile(
                    title: AppStrings.wednesday,
                    value: cardDetails.wednesday.toString(),
                    titleStyle: _titleStyle,
                    valueStyle: _valueStyle,
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
                    title: AppStrings.thursday,
                    value: cardDetails.thursday.toString(),
                    titleStyle: _titleStyle,
                    valueStyle: _valueStyle,
                  ),
                ),
                SizedBox(width: rowPadding),
                Expanded(
                  flex: 1,
                  child: TitleValueVerticalTile(
                    title: AppStrings.friday,
                    value: cardDetails.friday.toString(),
                    titleStyle: _titleStyle,
                    valueStyle: _valueStyle,
                  ),
                ),
                SizedBox(width: rowPadding),
                Expanded(
                  flex: 1,
                  child: TitleValueVerticalTile(
                    title: AppStrings.saturday,
                    value: cardDetails.saturday.toString(),
                    titleStyle: _titleStyle,
                    valueStyle: _valueStyle,
                  ),
                ),
                SizedBox(width: rowPadding),
                Expanded(
                  flex: 1,
                  child: TitleValueVerticalTile(
                    title: AppStrings.sunday,
                    value: cardDetails.sunday.toString(),
                    titleStyle: _titleStyle,
                    valueStyle: _valueStyle,
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
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0),
                    child: TitleValueVerticalTile(
                      title: AppStrings.total,
                      value: cardDetails.total.toString(),
                      titleStyle: _redTitleStyle,
                      valueStyle: _redValueStyle,
                    ),
                  ),
                ),
                SizedBox(width: rowPadding),
                Expanded(
                  flex: 4,
                  child: TitleValueVerticalTile(
                    title: AppStrings.comment,
                    value: cardDetails.comment,
                    titleStyle: _titleStyle,
                    valueStyle: _valueStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
