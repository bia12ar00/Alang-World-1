import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sb_portal/ui/auth/provider/AuthProvider.dart';
import 'package:sb_portal/ui/auth/view/SellerOtpVerifyScreen.dart';
import 'package:sb_portal/utils/app_images.dart';
import 'package:sb_portal/utils/app_string.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_font.dart';

class SendOtp extends StatefulWidget {
  final bool? isFromSeller;

  const SendOtp({Key? key, this.isFromSeller}) : super(key: key);

  @override
  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  AuthProvider? mAuthProvider;

  final TextEditingController _mobileController = TextEditingController();
  final FocusNode _mobileFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    print(widget.isFromSeller);
    mAuthProvider = Provider.of<AuthProvider>(context);
    return ModalProgressHUD (
      inAsyncCall: mAuthProvider!.isRequestSend,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.colorWhite,
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.isFromSeller! ? 'SELLER REGISTRATION' : 'BUYER REGISTRATION',
                  style: AppFont.NUNITO_SEMI_BOLD_BLACK_24,
                ),
                Container(
                  color: AppColors.colorBtnBlack,
                  width: 200,
                  height: 2,
                ),
                const SizedBox(height: 24),
                Text(
                  "Enter Mobile Number Here for \n Start Your Registration",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black.withOpacity(0.9),
                      fontFamily: 'RobotRegular'),
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _mobileController,
                        maxLength: 10,
                        textInputAction: TextInputAction.next,
                        style: AppFont.NUNITO_REGULAR_BLACK_14,
                        keyboardType: TextInputType.number,
                        focusNode: _mobileFocus,
                        onFieldSubmitted: (term) {
                          _mobileFocus.unfocus();
                        },
                        decoration: InputDecoration(
                          prefix: const Text(
                            '+91',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontFamily: 'RobotRegular'),
                          ) ,
                          isDense: true,
                          counterText: "",
                          hintText: '1111\t11\t1111',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withOpacity(1.0),
                              fontFamily: 'RobotRegular'),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  child: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.colorOrange,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: MaterialButton(
                          onPressed: _callSendOtp,
                          child: Text('SEND OTP',
                              style: TextStyle(
                                   fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(1.0),
                                  fontFamily: 'RobotRegular'),)),
                    ),
                  ),
                  onTap: () {},
                ),
                const SizedBox(height: 32),
                Flexible(
                  child: Image.asset(
                    APPImages.IC_SPLASH_LOGO,
                    width: 163,
                    height: 163,
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _callSendOtp() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Map<String, String> body = {
        APPStrings.paramMobile: _mobileController.text,
        APPStrings.paramType: 'seller',
      };

      mAuthProvider!.sendOtp(body).then((value) {
        print(value);
        if (value != null) {
          try {
            if (value["response"] != null && value["response"] == "success") {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SellerOtpVerifyScreen(
              )));
            } else {
              Fluttertoast.showToast(msg: value["message"]);
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
