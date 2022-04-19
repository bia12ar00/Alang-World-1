// ignore_for_file: prefer_const_constructors

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sb_portal/ui/auth/model/CommonModel.dart';
import 'package:sb_portal/ui/auth/provider/AuthProvider.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_font.dart';
import 'package:sb_portal/utils/app_images.dart';
import 'package:sb_portal/utils/app_string.dart';
import 'package:sb_portal/utils/app_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  AuthProvider? mAuthProvider;
  FocusNode emailFocus = FocusNode();
  TextEditingController emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Container(
          margin: EdgeInsets.only(top: 65, left: 66, right: 66),
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "FORGOT PASSWORD",
                  style: TextStyle(
                      color: AppColors.colorBlack, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 92, right: 92),
                height: 1,
                color: AppColors.colorBlack,
              ),
              const SizedBox(height: 35),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Enter Your Registered \n Email Address or Mobile Number \n for Re-Generate Your New Password",
                  style: TextStyle(color: AppColors.colorBlack),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              AppWidgets.buildInputFields(
                emailController,
                "Mobile Number/Email Address",
                false,
                emailFocus,
                emailFocus,
                context,
              ),
              const SizedBox(height: 18),
              GestureDetector(
                child: Material(
                  elevation: 0.0,
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.colorOrange,
                  child: Container(
                    margin: EdgeInsets.only(left: 18, right: 18),
                    alignment: Alignment.center,
                    height: 40,
                    child: MaterialButton(
                        onPressed: null,
                        child: Text('CONFIRM',
                            style: AppFont.NUNITO_BOLD_WHITE_24)),
                  ),
                ),
                onTap: () {
                  // isValid();
                },
              ),
              const SizedBox(height: 44),
              Image.asset(
                APPImages.IC_SPLASH_LOGO,
                width: 163,
                height: 163,
              ),
            ],
          ),
        ),
      ),
    );
  }

  callVerifyOtp() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Map<String, String> body = {
        APPStrings.paramEmail: _mobileController.text.toString(),
      };

      mAuthProvider!.verifyOtp(body).then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              CommonModel commonModel = CommonModel.fromJson(value);
              Fluttertoast.showToast(msg: commonModel.message!);
            }
          } catch (ex) {
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
