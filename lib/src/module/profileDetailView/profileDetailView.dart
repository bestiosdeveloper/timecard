import 'package:flutter/material.dart';
import 'package:timecard/src/module/utils/constants.dart';
import 'profileViewModel.dart';

class ProfileDetailView extends StatefulWidget {
  @override
  _ProfileDetailViewState createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  ProfileViewModel viewModel = ProfileViewModel();

  int selectedThemeIndex = 0;

  @override
  void initState() {
    super.initState();

    selectedThemeIndex = AppConstants.currentUser.themeColor;
    viewModel.fetchDetailsToShow();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double profileImageSize = 150.0;
    double profileContainerWidth = 350.0;
    double profileContainerLeft = (screenWidth - profileContainerWidth) / 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeBlueColor,
        title: Text(
            AppConstants.currentUser.firstName + AppStrings.myProfileTitle, style: TextStyle(color: AppColors.white),),
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: AppColors.themeBlueColor[200],
            ),
            clipper: ProfileBackGroundClipper(),
          ),
          Positioned(
            width: profileContainerWidth,
            left: profileContainerLeft,
            top: screenHeight / 6.8,
            child: Column(
              children: <Widget>[
                Container(
                  height: profileImageSize,
                  width: profileImageSize,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(AppConstants.currentUser.profilePic),
                    ),
                    borderRadius:
                        BorderRadius.all(Radius.circular(profileImageSize / 2)),
                    boxShadow: [
                      BoxShadow(blurRadius: 8.0, color: AppColors.black)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  AppConstants.currentUser.fullName,
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.themeBlueColor[900]),
                ),
                SizedBox(height: 5),
                Text(
                  AppConstants.currentUser.profileTitle,
                  style: TextStyle(
                      fontSize: 16, color: AppColors.themeBlueColor[700]),
                ),
                SizedBox(height: 30),
                _getProfileDetailsWidget(),
                SizedBox(height: 20),
                _getChooseThemeWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProfileDetailsWidget() {
    List<String> allKeys = viewModel.detailsToShow.keys.toList();
    return Container(
      height: viewModel.detailTileHeight,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemExtent: viewModel.detailRowHeight,
          itemCount: viewModel.detailsToShow.length,
          itemBuilder: (context, index) {
            String titleStr = allKeys[index];
            String valueStr = viewModel.detailsToShow[titleStr];
            return ProfileDetailRow(
              title: titleStr,
              value: valueStr,
              titleStyle: TextStyle(
                color: AppColors.themeBlueColor[900],
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
              valueStyle: TextStyle(
                  color: AppColors.themeBlueColor[900], fontSize: 14.0),
            );
          }),
    );
  }

  Widget _getChooseThemeWidget() {
    List<String> allKeys = viewModel.detailsToShow.keys.toList();
    double checkBoxHeight = 35.0;
    double checkBoxWidth = 35.0;

    return Card(
      color: AppColors.themeBlueColor[50],
      child: Container(
        height: 70,
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      "Choose theme color:",
                      style: TextStyle(
                        color: AppColors.themeBlueColor[900],
                        fontSize: 15.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: AppColors.themeColors.length,
                    itemBuilder: (context, index) {
                      return _getCheckboxWidget(index);
                    }),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }

  Widget _getCheckboxWidget(int index) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 35.0,
            width: 35.0,
            color: AppColors.themeColors[index],
            child: Checkbox(
              activeColor: AppColors.themeColors[index],
              value: (selectedThemeIndex == index),
              onChanged: (bool value) {
                viewModel.updateSelectedTheme(index, (isDone) {
                  setState(() {
                    selectedThemeIndex = index;
                  });
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDetailRow extends StatelessWidget {
  String title;
  String value;
  TextStyle titleStyle;
  TextStyle valueStyle;

  ProfileDetailRow(
      {this.title = "", this.value = "", this.titleStyle, this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.themeBlueColor[50],
      child: Container(
        padding: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Row(
          children: <Widget>[
            Expanded(flex: 2, child: Text(title, style: titleStyle)),
            Expanded(
                flex: 4,
                child:
                    Text(value, style: valueStyle, textAlign: TextAlign.right)),
          ],
        ),
      ),
    );
  }
}

class ProfileBackGroundClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return oldClipper != this;
  }

  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height / 2.5);
    path.lineTo(size.width * 1.8, 0.0);
    path.close();

    return path;
  }
}

