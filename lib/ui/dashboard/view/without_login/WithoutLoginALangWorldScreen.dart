import 'package:flutter/material.dart';
import 'package:sb_portal/ui/auth/view/SellerLogin.dart';
import 'package:sb_portal/ui/dashboard/view/without_login/widget/WithOutLoginSidemenu.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_font.dart';
import 'package:sb_portal/utils/app_images.dart';

class WithoutLoginALangWorldScreen extends StatefulWidget {
  const WithoutLoginALangWorldScreen({Key? key}) : super(key: key);

  @override
  _WithoutLoginALangWorldScreenState createState() => _WithoutLoginALangWorldScreenState();
}

class _WithoutLoginALangWorldScreenState extends State<WithoutLoginALangWorldScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const WithOutLoginSidemenu(),
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
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('About Alang World', style: AppFont.NUNITO_SEMI_BOLD_BLACK_20,),
                    const Divider(thickness: 2, endIndent: 20,),
                    const SizedBox(height: 16),
                    const Text('Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry   standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum')
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Container(
                      child: Column(
                        children: [
                          Text('SIGN UP/SIGN IN', style: AppFont.NUNITO_REGULAR_WHITE_12,),
                          Text('SELLER', style: AppFont.NUNITO_BOLD_WHITE_18,),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      color: AppColors.colorOrange,
                    ),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SellerLogin(
                                isFromSeller: true,
                              )),
                              (route) => false);
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const SellerLogin(
                                isFromSeller: false,
                              )),
                              (route) => false);
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Text('SIGN UP/SIGN IN',style: AppFont.NUNITO_REGULAR_WHITE_12,),
                          Text('BUYER', style: AppFont.NUNITO_BOLD_WHITE_18,),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      color: AppColors.colorSKyBlue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
