import 'package:flutter/material.dart';
import '../dashboard/sideMenuView.dart';
import '../utils/constants.dart';

class AddNewTimeCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenuView(),
      appBar: AppBar(
        title: Text(AppStrings.addNew),
      ),
      body: Center(
        child: Text("Welcome add new"),
      ),
    );
  }
}