import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import '../dashboard/dashboardView.dart';
import '../loginPage/loginView.dart';
import '../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: AppColors.themeBlueColor),
            ),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/launcher/ic_splash_logo.png',
                              height: 200.0, width: 200.0),
                          Padding(
                            padding: EdgeInsets.only(top: 0.0),
                          ),
                          Text(
                            AppConstants.appName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 28.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                        ),
                        Text(
                          AppStrings.splashQuote,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
            ),
          ],
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 2), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool(SharedPreferencesKeys.isLoggedIn) ?? false;
    print(status);
    if (status) {
      Navigator.pushReplacement(_scaffoldKey.currentContext, MaterialPageRoute(
          builder: (BuildContext context) => DashboardView())
      );
    } else {
      Navigator.pushReplacement(_scaffoldKey.currentContext, MaterialPageRoute(
          builder: (BuildContext context) => LoginView())
      );
    }
  }
}