import 'package:flutter/material.dart';
import 'package:timecard/presentation/custom_icons_icons.dart';
import 'loginViewModel.dart';
import '../utils/constants.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoginViewModel vm = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Builder(
        builder: (context) => SafeArea(
          child: Container(
            color: AppColors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(AppStrings.signIn, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeBlueColor,
                    fontSize: 28.0)
                ),
                SizedBox(height: 40.0),
                Column(
                  children: <Widget>[
                    Image.asset('assets/login/ic_ps_logo.png',
                        height: 80.0, width: 120.0),
                    SizedBox(height: 20.0),
                    Text(AppMessages.llIdRequired,
                        textAlign: TextAlign.center, style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.0)
                    ),
                  ],
                ),
                SizedBox(height: 80.0),
                TextField(
                  decoration: InputDecoration(
                    fillColor: AppColors.white,
                    labelText: AppStrings.lioLogin,
                    filled: true,
                  ),
                  onChanged: (text) {
                    this.vm.setLlId(text);
                  },
                ),
                SizedBox(height: 15.0),
                TextField(
                  decoration: InputDecoration(
                    fillColor: AppColors.white,
                    labelText: AppStrings.password,
                    filled: true,
                  ),
                  obscureText: true,
                  onChanged: (text) {
                    this.vm.setPassword(text);
                  },
                ),
                SizedBox(height: 15.0),
                ButtonBar(
                  children: <Widget>[
                    ClipOval(
                      child: Material(
                        color: AppColors.themeBlueColor, // button color
                        child: InkWell(
                          splashColor: AppColors.red, // inkwell color
                          child: SizedBox(
                              width: 56,
                              height: 56,
                              child: Icon(CustomIcons.arrow_forward, color: AppColors.white,)
                          ),
                          onTap: () {
                            this.vm.signInWithVerification(context);
                          },
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 80.0),
                Text(AppMessages.issueInLogin,
                    textAlign: TextAlign.center, style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15.0)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
