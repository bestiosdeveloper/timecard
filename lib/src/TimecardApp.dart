import 'package:flutter/material.dart';

void main() => runApp(TimecardApp());

class TimecardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login Screen",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(body: LoginPage()),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextStyle fontStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/login/ic_ps_logo.png', height: 80.0, width: 120.0),
                SizedBox(height: 20.0),
                Text('Your access requires your Lion Login (LL) ID \nPlease DO NOT USE your email address', textAlign: TextAlign.center, style: fontStyle),
              ],
            ),

            SizedBox(height: 120.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Lion Login',
                filled: true,
              ),
            ),

            SizedBox(height: 15.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                filled: true,
              ),
              obscureText: true,
            ),

            ButtonBar(
              children: <Widget>[
                RaisedButton(
                  child: Text('Sign In'),
                  onPressed: () {

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