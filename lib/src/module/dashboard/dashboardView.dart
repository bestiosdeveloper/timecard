import 'package:flutter/material.dart';
import 'package:timecard/src/module/models/userModel.dart';
import 'package:timecard/src/module/utils/constants.dart';
import 'sideMenuView.dart';
import 'sideMenuViewModel.dart';
import '../homeView/homeView.dart';
import '../addNewTimeCard/addNewTimeCardView.dart';
import '../historyView/historyView.dart';
import '../policyView/policyView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loginPage/loginView.dart';


class DashboardView extends StatefulWidget {
  DashboardView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> with SingleTickerProviderStateMixin{

  SideMenuViewModel viewModel = SideMenuViewModel();
  int _selectedDrawerIndex = 0;

  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  Color backgroundColor = AppColors.themeBlueColor;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return HomeView();
      case 1:
        return AddNewTimeCardView();
      case 2:
        return HistoryView();
      case 3:
        return PolicyView();
//      case 4:
//        return VacationTrackerView();
      case 4:
        logoutUser();
        break;

      default:
        return Center(
            child: Text("Under Development"),
        );
    }
  }

  SideMenuItem _getSelectedSideMenu() {
    return viewModel.menuOptions[_selectedDrawerIndex];
  }

  void logoutUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    AppConstants.currentUserId = "";
    AppConstants.currentUser = UserModel();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LoginView()));
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    _toggleSideMenu();
  }

  _toggleSideMenu() {
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
    });
  }

  @override
  void initState() {
    super.initState();
    AppConstants.lastSelectedSideMenu = 0;
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);

    viewModel.addListnerForThemeUpdate((isDone){
      setState(() {
        backgroundColor = AppColors.themeBlueColor;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: EdgeInsets.only(left: 0.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SideMenuView((index) {
              _onSelectItem(index);
            }),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {

    //subtracting 32 because whole container having 16 left and 16 right padding
    double menuContainerWidth = screenWidth - 20, menuContainerHeight = AppConstants.homeMenuContainerHeight;

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.4 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(isCollapsed ? 0 : 30)),
          elevation: isCollapsed ? 0 : 8,
          color: AppColors.white,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: EdgeInsets.only(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).padding.top
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    constraints: BoxConstraints.expand(height: menuContainerHeight),
                    child: Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        Positioned(
                          left: 0,
                          top: 0,
                          height: menuContainerHeight,
                          width: menuContainerHeight,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Container(
                                  width: menuContainerHeight,
                                  height: menuContainerHeight,
                                  child: Icon(
                                    Icons.menu,
                                    color: AppColors.themeBlueColor,
                                    size: 28,
                                  )
                              ),
                              onTap: () {
                                _toggleSideMenu();
                              },
                            ),
                          ),
                        ),
                        Positioned(
                          left: menuContainerHeight,
                          top: 0,
                          height: menuContainerHeight,
                          width: menuContainerWidth - (menuContainerHeight * 2),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                                _getSelectedSideMenu().title,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.themeBlueColor,
                                    fontWeight: FontWeight.bold,
                                )
                            ),
                          ),
                        ),
                        Positioned(
                          left: menuContainerWidth - menuContainerHeight,
                          top: 0,
                          height: menuContainerHeight,
                          width: menuContainerHeight,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              child: Container(
                                  width: menuContainerHeight,
                                  height: menuContainerHeight,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _getDrawerItemWidget(_selectedDrawerIndex),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}