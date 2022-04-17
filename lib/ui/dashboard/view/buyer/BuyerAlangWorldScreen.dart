import 'package:flutter/material.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerHomeScreenNavigation.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerSideMenu.dart';
import 'package:sb_portal/utils/NavKey.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_font.dart';
import 'package:sb_portal/utils/app_images.dart';

import '../widgets/about_us_body.dart';

class BuyerAlangWorldScreen extends StatefulWidget {
  const BuyerAlangWorldScreen({Key? key}) : super(key: key);

  @override
  _BuyerAlangWorldScreenState createState() => _BuyerAlangWorldScreenState();
}

class _BuyerAlangWorldScreenState extends State<BuyerAlangWorldScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
        backgroundColor: AppColors.colorWhite,
        body: AboutUsBody(),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (_position) {
            NavKey.navKey.currentState!.pushAndRemoveUntil(MaterialPageRoute(builder: (_) =>
                BuyerHomeScreenNavigation(selectedIndex: _position,)), (route) => false);
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
    );
  }
}
