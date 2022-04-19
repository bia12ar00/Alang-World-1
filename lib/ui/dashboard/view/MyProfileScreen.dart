import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sb_portal/ui/auth/model/CommonModel.dart';
import 'package:sb_portal/ui/dashboard/model/MyProfileModel.dart';
import 'package:sb_portal/ui/dashboard/provider/HomeProvider.dart';
import 'package:sb_portal/ui/dashboard/view/EditProfileScreen.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_font.dart';
import 'package:sb_portal/utils/app_string.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  HomeProvider? mHomeProvider;
  MyProfileModel myProfileModel = MyProfileModel();

  @override
  void initState() {
    callMyProfileApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mHomeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: mHomeProvider!.isRequestSend,
        child: Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: myProfileModel.results != null
              ? Column(
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          color: AppColors.colorLightBlueGrey,
                          border: Border.all(
                              color: AppColors.colorBorder, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Profile',
                                      style: AppFont.NUNITO_SEMI_BOLD_BLACK_24,
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(0.4),
                                      height: 2,
                                      width: 80,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                 EditProfileScreen(
                                                    myProfileModel:myProfileModel
                                                )));
                                    callMyProfileApi();
                                  },
                                  child: Container(
                                    height: 25,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.8),
                                        borderRadius: BorderRadius.circular(3)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Icon(
                                          FontAwesomeIcons.penToSquare,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text("EDIT",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'RobotRegular')),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const Icon(
                                  Icons.business,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  myProfileModel.results!.profile!.company!,
                                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.account_circle,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  myProfileModel.results!.profile!.name!,
                                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.call,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  myProfileModel.results!.profile!.mobile!,
                                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.email,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  myProfileModel.results!.profile!.email!,
                                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.cake_outlined,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  myProfileModel.results!.profile!.establishment_date!,
                                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  myProfileModel.results!.profile!.address!,
                                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  myProfileModel.results!.profile!.pincode!,
                                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 50),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          "assets/images/gender_icon.png"),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          myProfileModel
                                              .results!.profile!.gender!,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Colors.black.withOpacity(1.0),
                                              fontFamily: 'RobotRegular'))
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'City',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(1.0),
                                            fontFamily: 'RobotRegular'),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        endIndent: 20,
                                        color: Colors.black,
                                        height: 3,
                                      ),
                                      Text(
                                        myProfileModel
                                            .results!.profile!.district!,
                                        style: AppFont.NUNITO_BOLD_BLACK_16,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'State',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(1.0),
                                            fontFamily: 'RobotRegular'),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        endIndent: 20,
                                        color: Colors.black,
                                        height: 3,
                                      ),
                                      Text(
                                        myProfileModel.results!.profile!.state!,
                                        style: AppFont.NUNITO_BOLD_BLACK_16,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Country',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(1.0),
                                            fontFamily: 'RobotRegular'),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                        endIndent: 20,
                                        color: Colors.black,
                                        height: 3,
                                      ),
                                      Text(
                                        myProfileModel
                                            .results!.profile!.country!,
                                        style: AppFont.NUNITO_BOLD_BLACK_16,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 5),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: GestureDetector(
                            //     child: Material(
                            //       elevation: 0.0,
                            //       borderRadius: BorderRadius.circular(8),
                            //       color: AppColors.colorOrange,
                            //       child: Container(
                            //         alignment: Alignment.center,
                            //         height: 40,
                            //         child: MaterialButton(
                            //             onPressed: null,
                            //             child: Text('EDIT PROFILE',
                            //                 style: AppFont.NUNITO_BOLD_WHITE_24)),
                            //       ),
                            //     ),
                            //     onTap: () {
                            //       NavKey.navKey.currentState!.push(MaterialPageRoute(builder: (_) =>
                            //       EditProfileScreen(myProfileModel: myProfileModel,)));
                            //
                            //     },
                            //   ),
                            // ),
                            // const SizedBox(height: 12),
                            // Align(
                            //   alignment: Alignment.center,
                            //   child: GestureDetector(
                            //     child: Material(
                            //       elevation: 0.0,
                            //       borderRadius: BorderRadius.circular(8),
                            //       color: AppColors.colorOrange,
                            //       child: Container(
                            //         alignment: Alignment.center,
                            //         height: 40,
                            //         child: MaterialButton(
                            //             onPressed: null,
                            //             child: Text('CHANGE PASSWORD',
                            //                 style: AppFont.NUNITO_BOLD_WHITE_24)),
                            //       ),
                            //     ),
                            //     onTap: () {
                            //       NavKey.navKey.currentState!.push(MaterialPageRoute(builder: (_) =>
                            //           const SellerChangePasswordScreen()));
                            //
                            //     },
                            //   ),
                            // ),
                            // const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }

  callMyProfileApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      mHomeProvider!.getUserProfile().then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              myProfileModel = MyProfileModel.fromJson(value);
            }
          } catch (ex) {
            print(ex);
            Fluttertoast.showToast(msg: APPStrings.INTERNAL_SERVER_ISSUE);
          }
        } else {
          Fluttertoast.showToast(msg: APPStrings.INTERNAL_SERVER_ISSUE);
        }
      });
    } else {
      Fluttertoast.showToast(msg: APPStrings.noInternetConnection);
    }
  }
}
