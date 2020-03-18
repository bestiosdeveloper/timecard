import 'package:flutter/material.dart';
import 'loginViewModel.dart';
import '../utils/constants.dart';

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextStyle fontStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 12.0);
  LoginViewModel vm = new LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          children: <Widget>[
            SizedBox(height: 90.0),
            Column(
              children: <Widget>[
                Image.asset('assets/login/ic_ps_logo.png', height: 80.0, width: 120.0),
                SizedBox(height: 20.0),
                Text(AppMessages.llIdRequired, textAlign: TextAlign.center, style: fontStyle),
              ],
            ),

            SizedBox(height: 80.0),
            TextField(
              decoration: InputDecoration(
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
                labelText: AppStrings.password,
                filled: true,
              ),
              obscureText: true,
              onChanged: (text) {
                this.vm.setPassword(text);
              },
            ),

            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text(AppStrings.signIn),
                  onPressed: () {
                   this.vm.signInWithVerification(_scaffoldKey.currentContext);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}