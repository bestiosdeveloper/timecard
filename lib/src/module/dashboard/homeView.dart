import 'package:flutter/material.dart';
import 'sideMenuView.dart';
import '../utils/constants.dart';


class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuView(),
      appBar: AppBar(
        title: Text(AppStrings.home),
      ),
      body: Center(
        child: Text("Welcome Home"),
      ),
    );
  }
}