import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'sideMenuViewModel.dart';


class SideMenuView extends StatefulWidget {
  @override
  _SideMenuViewState createState() => _SideMenuViewState();

  Function(int) onTapCallBack;

  SideMenuView(this.onTapCallBack);
}

class _SideMenuViewState extends State<SideMenuView> {
  SideMenuViewModel viewModel = SideMenuViewModel();
  double screenWidth;

  void initState() {
    super.initState();

    //re-storing up last selection
    this.viewModel.menuOptions[AppConstants.lastSelectedSideMenu].isChosen = true;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;

    return Container(
      width: (0.6 * screenWidth) + 32,
      child: ListView.builder(
        itemCount: this.viewModel.menuOptions.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _getProfileHeader();
          } else {
            return _getListItemTile(context, index-1);
          }
        },
      ),
    );
  }

  Widget _getProfileHeader() {

    double profilePicSize = (0.15 * screenWidth);

    return GestureDetector(
      onTap: (){
        manageSelectionSelection(0);
        viewModel.goToProfileDetails(context);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            color: AppColors.themeBlueColor,
            child: Padding(
              padding: EdgeInsets.fromLTRB(12, 50, 5, 20),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Container(
                        width: profilePicSize,
                        height: profilePicSize,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image:
                                NetworkImage(AppConstants.currentUser.profilePic)))),
                    SizedBox(width: 0),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text(
                            AppConstants.currentUser.fullName,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            AppConstants.currentUser.profileTitle,
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return Container(
      color: this.viewModel.menuOptions[index].isChosen ? AppColors.selected[200] : AppColors.deselected,
      child: ListTile(
        leading: this.viewModel.menuOptions[index].icon,
        title: Text(this.viewModel.menuOptions[index].title, style:
          TextStyle(
              fontWeight: FontWeight.w500,
              color: this.viewModel.menuOptions[index].isChosen ? AppColors.selected[800] : AppColors.white,
          ),
        ),
        onTap: () {
          manageSelectionSelection(index);
        },
      ),
    );
  }

  manageSelectionSelection(int index) {
    if (AppConstants.lastSelectedSideMenu == index) {
      widget.onTapCallBack(index);
    }
    else {
      AppConstants.lastSelectedSideMenu = index;
      setState(() {
        for (var i = 0; i < this.viewModel.menuOptions.length; i++) {
          if (i == index) {
            this.viewModel.menuOptions[i].isChosen = true;
          }
          else {
            this.viewModel.menuOptions[i].isChosen = false;
          }
        }
      });

      widget.onTapCallBack(index);
    }
  }
}
