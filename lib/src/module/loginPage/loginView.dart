import 'package:flutter/material.dart';
import 'loginViewModel.dart';
import '../dashboard/dashboardView.dart';

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
                Text('Your access requires your Lion Login (LL) ID \nPlease DO NOT USE your email address', textAlign: TextAlign.center, style: fontStyle),
              ],
            ),

            SizedBox(height: 80.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Lion Login',
                filled: true,
              ),
              onChanged: (text) {
                this.vm.setLlId(text);
              },
            ),

            SizedBox(height: 15.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
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
                  child: Text('Sign In'),
                  onPressed: () {
                   signinWithVerification();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  signinWithVerification() {
    if (isDataValid()) {
      goToDashboard();
    }
  }

  bool isDataValid() {
    if (this.vm.llId.isEmpty) {
      showSnackbar("Please enter LL id.");
      return false;
    }
    else if (this.vm.password.isEmpty) {
      showSnackbar("Please enter password.");
      return false;
    }
    else {
      return true;
    }
  }

  goToDashboard() {
    Navigator.push(
      _scaffoldKey.currentContext,
      MaterialPageRoute(builder: (context) => DashboardView()),
    );
  }

  showSnackbar(String message, {int duration = 1}) {
    _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: duration),
        ));
  }
}