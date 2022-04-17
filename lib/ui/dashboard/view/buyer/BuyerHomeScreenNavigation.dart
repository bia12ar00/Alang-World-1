import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerCategoryNameScreen.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerHomeScreen.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerMyProfileSCreen.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerSideMenu.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_images.dart';
import 'package:sb_portal/utils/common/show_single_dialog.dart';

class BuyerHomeScreenNavigation extends StatefulWidget {
  int? selectedIndex = 0;
  BuyerHomeScreenNavigation({Key? key, this.selectedIndex}) : super(key: key);

  @override
  _BuyerHomeScreenNavigationState createState() => _BuyerHomeScreenNavigationState();
}

class _BuyerHomeScreenNavigationState extends State<BuyerHomeScreenNavigation> {
  int page = 0;

  @override
  void initState() {
    page = widget.selectedIndex!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _onWillPop();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          drawer: const BuyerSideMenu(),
          appBar: AppBar(
              toolbarHeight: 80,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.menu),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                    Expanded(child: Image.asset(APPImages.IC_SPLASH_LOGO, height: 73, width: 73,)),
                    IconButton(
                      color: Colors.black,
                      icon: const Icon(Icons.notifications),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              backgroundColor: AppColors.colorWhite,
              elevation: 0.0),
          body: getBody(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: page,
            onTap: (_position) {
              setState(() {
                page = _position;
              });
            },
            showSelectedLabels: false,
            selectedItemColor: AppColors.colorWhite,
            backgroundColor: AppColors.colorBlack,
            selectedFontSize: 12.00,
            unselectedFontSize: 12.00,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 32,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search,  size: 32,),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle,  size: 32,),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget? getBody() {
    if (page == 0) {
      return const BuyerHomeScreen();
    } else if (page == 1) {
      return  const BuyerCategoryNameScreen();
    } else if (page == 2) {
      return const BuyerMyProfileScreen();
    }
  }

  _onWillPop()  {
    DialogSingleClick.showCustomDialog(context,
        title: 'Do you want to exit an app',
        okBtnText: 'OK',
        cancelBtnText: 'Cancel',
        okBtnFunction: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        });
  }
}
