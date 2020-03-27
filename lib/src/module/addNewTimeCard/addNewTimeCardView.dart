import 'package:flutter/material.dart';
import 'addNewTimeCardViewModel.dart';
import '../utils/constants.dart';
import 'suggestedTimeCardView.dart';
import '../models/weekTimeCardModel.dart';
import '../models/projectTimeCardModel.dart';

class AddNewTimeCardView extends StatefulWidget {
  @override
  _AddNewTimeCardViewState createState() => _AddNewTimeCardViewState();
}

class _AddNewTimeCardViewState extends State<AddNewTimeCardView> {
  AddNewTimeCardViewModel viewModel = AddNewTimeCardViewModel();

  int totalCardToShow = 0;
  bool shouldUpdate = false;
  int currentSelectedCardIndex = 0;

  @override
  void initState() {
    super.initState();

    viewModel.timeCardDetails.addNewBlankEntry();
    totalCardToShow = viewModel.timeCardDetails.allTimeCards.length;
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
          _getMessageHeaderWidget(),
          SizedBox(height: 20.0),
          _getAddNewCardWidget(),
          SizedBox(height: 30.0),
          SuggestedTimeCardView(
            onApply: (ProjectTimeCardModel cardDetails) {
              viewModel.timeCardDetails.allTimeCards[currentSelectedCardIndex] =
                  cardDetails;
              setState(() {
                shouldUpdate = true;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _getMessageHeaderWidget() {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: <Widget>[
          Text(
            viewModel.message,
            style: TextStyle(
              fontSize: 11,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAddNewCardWidget() {
    double timeCardsHeight =
        (totalCardToShow * (viewModel.defaultCardHeight + 10));
    double totalHeight = timeCardsHeight +
        viewModel.grandTotalCardHeight +
        viewModel.addNewEntryButtonHeight +
        20.0;
    return Container(
      height: totalHeight,
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: AppColors.themeBlueColor[50],
        elevation: 3,
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: viewModel.timeCardDetails.allTimeCards.length + 2,
            itemBuilder: (context, index) {
              if (index < totalCardToShow) {
                return _getCardDetailTile(index, (value) {
                  viewModel.validateCardDetails(context);
                  setState(() {
                    shouldUpdate = value;
                  });
                }, (idx) {
                  setState(() {
                    currentSelectedCardIndex = idx;
                  });
                });
              } else if (index == totalCardToShow) {
                return _getGrandTotalTile(index);
              } else {
                return Container(
                  padding: EdgeInsets.only(left: 15),
                  child: ButtonBar(
                      buttonHeight: viewModel.addNewEntryButtonHeight,
                      alignment: MainAxisAlignment.start,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: AppColors.themeBlueColor,
                          child: Text("Add New Entry",
                              style: TextStyle(
                                  fontSize: 17, color: AppColors.white)),
                          onPressed: () {
                            viewModel.timeCardDetails.addNewBlankEntry();
                            setState(() {
                              totalCardToShow =
                                  viewModel.timeCardDetails.allTimeCards.length;
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: AppColors.themeBlueColor,
                          child: Text("  Submit  ",
                              style: TextStyle(
                                  fontSize: 17, color: AppColors.white)),
                          onPressed: () {
                            viewModel.saveDataToServer();
                          },
                        )
                      ]),
                );
              }
            }),
      ),
    );
  }

  Widget _getCardDetailTile(
      int index, ValueChanged<bool> onChanged, ValueChanged<int> onSelect) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        Container(
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: AppColors.themeBlueColor[100],
            elevation: 1,
            child: GestureDetector(
              onTap: () {
                onSelect(index);
              },
              child: CardDetailTile(
                viewModel.timeCardDetails.allTimeCards[index],
                isSelected: (index == currentSelectedCardIndex),
                size: Size(screenWidth - 32, viewModel.defaultCardHeight),
                onChanged: (bool value) {
                  onChanged(value);
                },
              ),
            ),
          ),
        ),
        SizedBox(height: 5.0),
      ],
    );
  }

  Widget _getGrandTotalTile(int index) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        Container(
          child: Material(
            color: AppColors.themeBlueColor[100],
            elevation: 1,
            child: GrandTotalTile(
              viewModel.timeCardDetails,
              size: Size(screenWidth - 32, viewModel.grandTotalCardHeight),
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}

class GrandTotalTile extends StatelessWidget {
  const GrandTotalTile(
    this.weekCardDetails, {
    this.size = Size.zero,
  }) : assert(
          weekCardDetails != null,
        );

  final WeekTimeCardModel weekCardDetails;
  final Size size;

  @override
  Widget build(BuildContext context) {
    double rowPadding = 5.0;
    double columnPadding = 10.0;
    double textFieldHeight = 40.0;
    Color titleColor = AppColors.red;
    Color valueColor = AppColors.red;

    return Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.only(top: rowPadding, left: rowPadding),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: TitleValueVerticalTile(
                      title: AppStrings.total,
                      value: weekCardDetails.total.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 3,
                    child: TitleValueVerticalTile(
                      title: AppStrings.monday,
                      value: weekCardDetails.monday.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 3,
                    child: TitleValueVerticalTile(
                      title: AppStrings.tuesday,
                      value: weekCardDetails.tuesday.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 3,
                    child: TitleValueVerticalTile(
                      title: AppStrings.wednesday,
                      value: weekCardDetails.wednesday.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(width: columnPadding),
            Expanded(
              flex: 1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.thursday,
                      value: weekCardDetails.thursday.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.friday,
                      value: weekCardDetails.friday.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.saturday,
                      value: weekCardDetails.saturday.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: TitleValueVerticalTile(
                      title: AppStrings.sunday,
                      value: weekCardDetails.sunday.toString(),
                      titleStyle: TextStyle(
                        color: titleColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                      valueStyle: TextStyle(color: valueColor, fontSize: 13.0),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}

class CardDetailTile extends StatelessWidget {
  const CardDetailTile(
    this.cardDetails, {
    this.size = Size.zero,
    this.onChanged,
    this.isSelected = false,
  }) : assert(
          cardDetails != null,
        );

  final ProjectTimeCardModel cardDetails;
  final Size size;
  final ValueChanged<bool> onChanged;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    double rowPadding = 5.0;
    double columnPadding = 10.0;
    double textFieldHeight = 40.0;

    return Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          border: Border.all(
              color: AppColors.themeBlueColor, width: isSelected ? 2 : 0),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: EdgeInsets.only(
            left: rowPadding, right: rowPadding, top: rowPadding),
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
                      child: InputTextField(
                        title: "PID",
                        text: cardDetails.pid,
                        keyboardType: TextInputType.number,
                        height: textFieldHeight,
                        onChanged: (String value) {
                          cardDetails.pid = value;
                          onChanged(true);
                        },
                      ),
                    ),
                    SizedBox(width: rowPadding),
                    Expanded(
                      flex: 4,
                      child: InputTextField(
                        title: "Type",
                        text: cardDetails.type,
                        height: textFieldHeight,
                        onChanged: (String value) {
                          cardDetails.type = value;
                          onChanged(true);
                        },
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
                      flex: 4,
                      child: InputTextField(
                        title: "Location",
                        text: cardDetails.location,
                        height: textFieldHeight,
                        onChanged: (String value) {
                          cardDetails.location = value;
                          onChanged(true);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: CheckboxTile(
                        title: "Billable?",
                        isSelected: cardDetails.isBillable,
                        onChanged: (bool value) {
                          cardDetails.isBillable = value;
                          onChanged(true);
                        },
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
                    child: InputTextField(
                      title: "Monday",
                      text: cardDetails.monday.toString(),
                      keyboardType: TextInputType.number,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.monday = double.parse(value);
                        onChanged(true);
                      },
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: InputTextField(
                      title: "Tuesday",
                      text: cardDetails.tuesday.toString(),
                      keyboardType: TextInputType.number,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.tuesday = double.parse(value);
                        onChanged(true);
                      },
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: InputTextField(
                      title: "Wednesday",
                      text: cardDetails.wednesday.toString(),
                      keyboardType: TextInputType.number,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.wednesday = double.parse(value);
                        onChanged(true);
                      },
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
                    child: InputTextField(
                      title: "Thursday",
                      text: cardDetails.thursday.toString(),
                      keyboardType: TextInputType.number,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.thursday = double.parse(value);
                        onChanged(true);
                      },
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: InputTextField(
                      title: "Friday",
                      text: cardDetails.friday.toString(),
                      keyboardType: TextInputType.number,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.friday = double.parse(value);
                        onChanged(true);
                      },
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: InputTextField(
                      title: "Saturday",
                      text: cardDetails.saturday.toString(),
                      keyboardType: TextInputType.number,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.saturday = double.parse(value);
                        onChanged(true);
                      },
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 1,
                    child: InputTextField(
                      title: "Sunday",
                      text: cardDetails.sunday.toString(),
                      keyboardType: TextInputType.number,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.sunday = double.parse(value);
                        onChanged(true);
                      },
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
                        title: "Total",
                        value: cardDetails.total.toString(),
                        titleStyle: TextStyle(
                          color: AppColors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                        valueStyle:
                            TextStyle(color: AppColors.red, fontSize: 13.0),
                      ),
                    ),
                  ),
                  SizedBox(width: rowPadding),
                  Expanded(
                    flex: 4,
                    child: InputTextField(
                      title: "Comment",
                      text: cardDetails.comment,
                      height: textFieldHeight,
                      onChanged: (String value) {
                        cardDetails.comment = value;
                        onChanged(true);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class InputTextField extends StatelessWidget {
  String title = "";
  String text = "";
  double width = 0.0;
  double height = 0.0;
  EdgeInsets contentPadding = EdgeInsets.all(5.0);
  TextInputType keyboardType = TextInputType.text;
  final ValueChanged<String> onChanged;

  InputTextField(
      {this.title,
      this.text,
      this.width,
      this.height,
      this.contentPadding,
      this.keyboardType,
      this.onChanged});

  TextEditingController _controller;


  @override
  Widget build(BuildContext context) {
    _controller = TextEditingController(text: text);
    return Column(
      children: <Widget>[
        Text(title,
            style: TextStyle(
              fontSize: 13,
            )),
        SizedBox(height: 5.0),
        Container(
          width: width,
          height: height,
          child: TextField(
            maxLines: 1,
            controller: _controller,
            textInputAction: TextInputAction.done,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              isDense: true,
              hasFloatingPlaceholder: false,
              contentPadding: contentPadding,
              border: OutlineInputBorder(
                gapPadding: 1.0,
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            onChanged: (String value) {
              onChanged(value);
            },
          ),
        ),
      ],
    );
  }
}

class TitleValueVerticalTile extends StatelessWidget {
  String title = "";
  String value = "";
  TextStyle titleStyle;
  TextStyle valueStyle;

  TitleValueVerticalTile(
      {this.title = "", this.value = "", this.titleStyle, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
        SizedBox(height: 5.0),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: valueStyle,
          ),
        )
      ],
    );
  }
}

class CheckboxTile extends StatelessWidget {
  String title = "";
  TextStyle titleStyle;
  bool isSelected = false;
  final ValueChanged<bool> onChanged;

  CheckboxTile(
      {this.title = "",
      this.isSelected = false,
      this.titleStyle,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
        Expanded(
          flex: 8,
          child: Checkbox(
            value: isSelected,
            onChanged: (bool value) {
              onChanged(value);
            },
          ),
        )
      ],
    );
  }
}
