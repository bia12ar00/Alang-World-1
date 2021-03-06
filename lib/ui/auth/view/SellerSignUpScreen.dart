import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sb_portal/service/network_repository.dart';
import 'package:sb_portal/ui/auth/model/CommonModel.dart';
import 'package:sb_portal/ui/auth/model/SignUpModel.dart';
import 'package:sb_portal/ui/auth/provider/AuthProvider.dart';
import 'package:sb_portal/ui/auth/view/SellerOtpVerifyScreen.dart';
import 'package:sb_portal/ui/dashboard/model/CityModel.dart';
import 'package:sb_portal/ui/dashboard/model/CountryModel.dart';
import 'package:sb_portal/ui/dashboard/model/StateModel.dart';
import 'package:sb_portal/ui/helper/FirebaseNotificationHelper.dart';
import 'package:sb_portal/utils/NavKey.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_font.dart';
import 'package:sb_portal/utils/app_images.dart';
import 'package:sb_portal/utils/app_string.dart';
import 'package:sb_portal/utils/app_widgets.dart';
import 'package:sb_portal/utils/common/EmailValidator.dart';
import 'package:sb_portal/utils/preference_helper.dart';
import 'package:http/http.dart' as http;

class SellerSignUpScreen extends StatefulWidget {
  final bool? isFromSeller;

  const SellerSignUpScreen({Key? key, this.isFromSeller}) : super(key: key);

  @override
  _SellerSignUpScreenState createState() => _SellerSignUpScreenState();
}

class _SellerSignUpScreenState extends State<SellerSignUpScreen> {
  AuthProvider? mAuthProvider;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _companyAddressController =
      TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _companyNameFocus = FocusNode();
  final FocusNode _mobileFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _companyAddressFocus = FocusNode();
  final FocusNode _stateFocus = FocusNode();
  final FocusNode _pinCodeFocus = FocusNode();
  final FocusNode _dobFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  CountryModel countryModel = CountryModel();
  Countries? selectedCountry;

  StateModel stateModel = StateModel();
  States? selectedState;

  CityModel cityModel = CityModel();
  Cities? selectedCity;

  DateTime selectedDate = DateTime.now();
  bool value = false;

  List<String> genderList = [];
  String? selectGender;

  @override
  void initState() {
    callCountryListApi();
    genderList.add('Male');
    genderList.add('Female');
    genderList.add('Other');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mAuthProvider = Provider.of<AuthProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: mAuthProvider!.isRequestSend,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.colorWhite,
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                              widget.isFromSeller!
                                  ? 'SELLER REGISTRATION'
                                  : 'BUYER REGISTRATION',
                              style: AppFont.NUNITO_SEMI_BOLD_BLACK_24),
                          Container(
                            color: AppColors.colorBtnBlack,
                            width: 184,
                            height: 2,
                          ),
                        ],
                      ),
                      const SizedBox(width: 18),
                      Image.asset(
                        APPImages.IC_SPLASH_LOGO,
                        width: 48,
                        height: 48,
                      ),
                    ],
                  ),
                  widget.isFromSeller!
                      ? const SizedBox(height: 58)
                      : const SizedBox(height: 0),
                  widget.isFromSeller!
                      ? AppWidgets.buildInputFields(
                          _companyNameController,
                          "Company name",
                          false,
                          _companyNameFocus,
                          _nameFocus,
                          context,
                        )
                      : const SizedBox(),
                  widget.isFromSeller!
                      ? const SizedBox(height: 16)
                      : const SizedBox(height: 48),
                  AppWidgets.buildInputFields(
                    _nameController,
                    widget.isFromSeller! ? "Contact person name" : "Full Name",
                    false,
                    _nameFocus,
                    _mobileFocus,
                    context,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '+91',
                            style: AppFont.NUNITO_REGULAR_BLACK_14,
                          ),
                          const SizedBox(height: 12),
                          Container(
                            color: AppColors.colorBtnBlack,
                            width: 32,
                            height: 1,
                          ),
                        ],
                      ),
                      const SizedBox(width: 16),
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
                            FocusScope.of(context).requestFocus(_emailFocus);
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            counterText: "",
                            hintText: 'Mobile number',
                            hintStyle: AppFont.NUNITO_REGULAR_BLACK_14,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppWidgets.buildInputFields(_emailController, "Email Address",
                      false, _emailFocus, _companyAddressFocus, context,
                      isEmailField: true),
                  const SizedBox(height: 16),
                  AppWidgets.buildInputFields(
                    _companyAddressController,
                    widget.isFromSeller! ? "Company address" : "Address",
                    false,
                    _companyAddressFocus,
                    _stateFocus,
                    context,
                  ),
                  const SizedBox(height: 16),
                  countryModel.results != null
                      ? DropdownButton<Countries>(
                          hint: selectedCountry == null
                              ? const Text('Country')
                              : Text(selectedCountry!.name!),
                          underline: Container(),
                          isExpanded: true,
                          items: countryModel.results!.countries!
                              .map((Countries value) {
                            return DropdownMenuItem<Countries>(
                              value: value,
                              child: Text(value.name!),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            setState(() {
                              selectedCountry = newValue;
                            });
                            callStateListApi();
                          },
                        )
                      : const SizedBox(),
                  Container(
                    color: AppColors.colorBtnBlack,
                    width: double.maxFinite,
                    height: 1,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            DropdownButton<States>(
                              hint: selectedState == null
                                  ? const Text('State')
                                  : Text(selectedState!.name!),
                              underline: Container(),
                              isExpanded: true,
                              items: stateModel.results == null
                                  ? []
                                  : stateModel.results!.states!
                                      .map((States value) {
                                      return DropdownMenuItem<States>(
                                        value: value,
                                        child: Text(value.name!),
                                      );
                                    }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedState = newValue;
                                });
                                callCityListApi();
                              },
                            ),
                            Container(
                              color: AppColors.colorBtnBlack,
                              width: double.maxFinite,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            DropdownButton<Cities>(
                              hint: selectedCity == null
                                  ? const Text('City')
                                  : Text(selectedCity!.name!),
                              underline: Container(),
                              isExpanded: true,
                              items: cityModel.results == null
                                  ? []
                                  : cityModel.results!.cities!
                                      .map((Cities value) {
                                      return DropdownMenuItem<Cities>(
                                        value: value,
                                        child: Text(value.name!),
                                      );
                                    }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCity = newValue;
                                });
                              },
                            ),
                            Container(
                              color: AppColors.colorBtnBlack,
                              width: double.maxFinite,
                              height: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            AppWidgets.buildInputFieldsWithNumber(
                              _pinCodeController,
                              "Pincode",
                              false,
                              _pinCodeFocus,
                              _passwordFocus,
                              context,
                            ),
                            Container(
                              height: 1,
                              width: double.maxFinite,
                              color: AppColors.colorBtnBlack,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              AppWidgets.buildInputFieldsWithNumber(
                                  _dateOfBirthController,
                                  "Date of Birth",
                                  false,
                                  _dobFocus,
                                  _passwordFocus,
                                  context,
                                  isEnable: false),
                              Container(
                                height: 1,
                                width: double.maxFinite,
                                color: AppColors.colorBtnBlack,
                              )
                            ],
                          ),
                          onTap: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  widget.isFromSeller!
                      ? const SizedBox()
                      : Column(
                          children: [
                            DropdownButton<String>(
                              hint: selectGender == null
                                  ? const Text('Gender')
                                  : Text(selectGender!),
                              underline: Container(),
                              isExpanded: true,
                              items: genderList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectGender = newValue;
                                });
                              },
                            ),
                            Container(
                              color: AppColors.colorBtnBlack,
                              width: double.maxFinite,
                              height: 1,
                            ),
                          ],
                        ),
                  const SizedBox(height: 16),
                  AppWidgets.buildInputFields(
                    _passwordController,
                    "Enter password",
                    true,
                    _passwordFocus,
                    _confirmPasswordFocus,
                    context,
                  ),
                  const SizedBox(height: 16),
                  AppWidgets.buildInputFields(
                    _confirmPasswordController,
                    "Enter confirm password",
                    true,
                    _confirmPasswordFocus,
                    null,
                    context,
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: Icon(
                              value
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                            ),
                            onTap: () {
                              setState(() {
                                value = !value;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Accept Our '),
                                TextSpan(
                                  text: 'Terms & Condition',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    child: Material(
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.colorOrange,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: MaterialButton(
                            onPressed: null,
                            child: Text('REGISTER',
                                style: AppFont.NUNITO_BOLD_WHITE_24)),
                      ),
                    ),
                    onTap: () {
                      isValid();
                    },
                  ),
                  const SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      NavKey.navKey.currentState!.pop();
                    },
                    child: const Text(
                      'BACK TO HOME',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateOfBirthController.text = picked.day.toString() +
            "-" +
            picked.month.toString() +
            "-" +
            picked.year.toString();
      });
    }
  }

  isValid() {
    if (widget.isFromSeller! &&
        _companyNameController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter company name');
    } else if (_nameController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter name');
    } else if (_mobileController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter mobile number');
    } else if (_mobileController.text.toString().length < 10) {
      Fluttertoast.showToast(msg: 'Please enter valid mobile number');
    } else if (_emailController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter email');
    } else if (!EmailValidator.validate(
        _emailController.text.toString().trim())) {
      Fluttertoast.showToast(msg: 'Please enter valid email');
    } else if (_companyAddressController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter company address');
    } else if (selectedCountry == null) {
      Fluttertoast.showToast(msg: 'Please select country');
    } else if (selectedState == null) {
      Fluttertoast.showToast(msg: 'Please select state');
    } else if (selectedCity == null) {
      Fluttertoast.showToast(msg: 'Please select city');
    } else if (_pinCodeController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter pincode');
    } else if (_pinCodeController.text.toString().length < 6) {
      Fluttertoast.showToast(msg: 'Please enter valid pincode');
    } else if (!widget.isFromSeller! && selectGender == null) {
      Fluttertoast.showToast(msg: 'Please select gender');
    } else if (_passwordController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter password');
    } else if (_confirmPasswordController.text.toString().trim().isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter confirm password');
    } else if (_passwordController.text.toString().trim() !=
        _confirmPasswordController.text.toString().trim()) {
      Fluttertoast.showToast(
          msg: 'Password and confirm password dose not match');
    } else if (!value) {
      Fluttertoast.showToast(msg: 'Please select term and condition');
    } else {
      sendOtp(_mobileController.text);
      callSignUpApi();
      setState(() {
        otpNumber = _mobileController.text.toString();
      });
    }
  }

  callSignUpApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String? firebaseToken =
          await FirebaseNotificationHelper.getInstance().getFcmToken();

      Map<String, String> body = widget.isFromSeller!
          ? {
              APPStrings.paramName: _nameController.text.toString().trim(),
              APPStrings.paramEmail: _emailController.text.toString().trim(),
              APPStrings.paramPassword:
                  _passwordController.text.toString().trim(),
              APPStrings.paramCPassword:
                  _confirmPasswordController.text.toString().trim(),
              APPStrings.paramType: widget.isFromSeller! ? 'seller' : 'buyer',
              APPStrings.paramMobile: _mobileController.text.toString(),
              APPStrings.paramCompany:
                  _companyNameController.text.toString().trim(),
              APPStrings.paramPincode:
                  _pinCodeController.text.toString().trim(),
              APPStrings.paramAddress:
                  _companyAddressController.text.toString().trim(),
              APPStrings.paramDistrict: selectedCity!.name!,
              APPStrings.paramState: selectedState!.name!,
              APPStrings.paramCountry: selectedCountry!.name!,
              APPStrings.paramEstablishmentDate:
                  _dateOfBirthController.text.toString(),
              APPStrings.paramFirebaseId: firebaseToken!,
            }
          : {
              APPStrings.paramName: _nameController.text.toString().trim(),
              APPStrings.paramEmail: _emailController.text.toString().trim(),
              APPStrings.paramPassword:
                  _passwordController.text.toString().trim(),
              APPStrings.paramCPassword:
                  _confirmPasswordController.text.toString().trim(),
              APPStrings.paramType: widget.isFromSeller! ? 'seller' : 'buyer',
              APPStrings.paramMobile: _mobileController.text.toString(),
              APPStrings.paramPincode:
                  _pinCodeController.text.toString().trim(),
              APPStrings.paramAddress:
                  _companyAddressController.text.toString().trim(),
              APPStrings.paramDistrict: selectedCity!.name!,
              APPStrings.paramState: selectedState!.name!,
              APPStrings.paramCountry: selectedCountry!.name!,
              APPStrings.paramEstablishmentDate:
                  _dateOfBirthController.text.toString(),
              APPStrings.paramGender: selectGender!,
              APPStrings.paramFirebaseId: firebaseToken!,
            };

      mAuthProvider!.signUp(body).then((value) {
        try {
          CommonModel streams = CommonModel.fromJson(value);
          if (streams.response != null && streams.response == "error") {
            Fluttertoast.showToast(msg: streams.message);
          } else {
            SignUpModel signUpModel = SignUpModel.fromJson(value);
            Fluttertoast.showToast(msg: signUpModel.message!);
            PreferenceHelper.setString(PreferenceHelper.AUTH_TOKEN,
                signUpModel.results!.user!.userDetails!.token!);
            NavKey.navKey.currentState!.push(MaterialPageRoute(
                builder: (_) => SellerOtpVerifyScreen(
                      isFromSeller: widget.isFromSeller!,
                    )));
          }
        } catch (ex) {
          Fluttertoast.showToast(msg: APPStrings.INTERNAL_SERVER_ISSUE);
        }
      });
    } else {
      Fluttertoast.showToast(msg: APPStrings.noInternetConnection);
    }
  }

  sendOtp(String mobile) async {
    Map<String, dynamic> params = {"mobile": mobile};
    String _timezone = await FlutterNativeTimezone.getLocalTimezone();
    commonHeaders['timezone'] = _timezone;
    commonHeaders['Authorization'] =
        "Bearer " + PreferenceHelper.getString(PreferenceHelper.AUTH_TOKEN);

    printWrapped(
        "Bearer--" + PreferenceHelper.getString(PreferenceHelper.AUTH_TOKEN));
    printWrapped("baseUrl--" + APPStrings.baseUrl + "send_otp");
    printWrapped("baseUrl--body-" + params.toString());
    printWrapped("baseUrl--commonHeaders-" + commonHeaders.toString());

    var response = await http.post(Uri.parse(APPStrings.baseUrl + "send_otp"),
        body: params, headers: commonHeaders);

    Map<String, dynamic> data = jsonDecode(response.body);
    String verse = data["results"]["OTPSession"];
    print("sessionID:- $verse");

    sessionID = verse;
    setState(() {});
    // SendOtpModel commonModel = SendOtpModel.fromJson(data);
    // sessionID = commonModel.results!.oTPSession;
    // print(commonModel);
  }

  callCountryListApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      mAuthProvider!.getCountryList().then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              countryModel = CountryModel.fromJson(value);
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

  callStateListApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Map<String, String> body = {
        APPStrings.paramCountry: selectedCountry!.name!
      };
      mAuthProvider!.getStateList(body).then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              stateModel = StateModel.fromJson(value);
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

  callCityListApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      Map<String, String> body = {APPStrings.paramState: selectedState!.name!};
      mAuthProvider!.getCityList(body).then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              cityModel = CityModel.fromJson(value);
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
