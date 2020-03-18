import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'sideMenuViewModel.dart';
import '../addNewTimeCard/addNewTimeCardView.dart';


class SideMenuView extends StatefulWidget {
  @override
  _SideMenuViewState createState() => _SideMenuViewState();
}

class _SideMenuViewState extends State<SideMenuView> {
  SideMenuViewModel viewModel = new SideMenuViewModel();

  void initState() {
    super.initState();

    //re-storing up last selection
    this.viewModel.menuOptions[AppConstants.lastSelectedSideMenu].isChoosen = true;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: this.viewModel.menuOptions.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              color: AppColors.themeWhiteColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 50, 5, 20),
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                          width: 80.0,
                          height: 80.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image:
                                      NetworkImage(AppStrings.profileImage)))),
                      SizedBox(width: 8),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Pramod Kumar",
                              style: TextStyle(
                                  color: AppColors.black, fontSize: 25),
                            ),
                            Text(
                              "Software mobile developer",
                              style: TextStyle(
                                  color: AppColors.gray, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return _getListItemTile(context, index-1);
          }
        },
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return Container(
      color: this.viewModel.menuOptions[index].isChoosen ? AppColors.selected[100] : AppColors.deselected,
      child: ListTile(
        leading: this.viewModel.menuOptions[index].icon,
        title: Text(this.viewModel.menuOptions[index].title),
        onTap: () {
          if (AppConstants.lastSelectedSideMenu == index) {
            Navigator.pop(context);
          }
          else {
            AppConstants.lastSelectedSideMenu = index;
            setState(() {
              for (var i = 0; i < this.viewModel.menuOptions.length; i++) {
                if (i == index) {
                  this.viewModel.menuOptions[i].isChoosen = true;
                }
                else {
                  this.viewModel.menuOptions[i].isChoosen = false;
                }
              }
            });

            Navigator.pop(context);
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => AddNewTimeCardView()),
//            );
          }
        },
      ),
    );
  }
}
