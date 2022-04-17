import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sb_portal/ui/auth/model/CommonModel.dart';
import 'package:sb_portal/ui/dashboard/model/ProductCategoryModel.dart';
import 'package:sb_portal/ui/dashboard/model/SliderModel.dart';
import 'package:sb_portal/ui/dashboard/model/SwipeWidgetModel.dart';
import 'package:sb_portal/ui/dashboard/model/WIthOutLoginProductListModel.dart';
import 'package:sb_portal/ui/dashboard/provider/HomeProvider.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerCategoryNameScreen.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerHomeScreenNavigation.dart';
import 'package:sb_portal/ui/dashboard/view/buyer/BuyerSideMenu.dart';
import 'package:sb_portal/utils/NavKey.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_font.dart';
import 'package:sb_portal/utils/app_images.dart';
import 'package:sb_portal/utils/app_string.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({Key? key}) : super(key: key);

  @override
  _BuyerHomeScreenState createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  ProductCategoryModel productCategoryModel = ProductCategoryModel();
  SliderModel sliderModel = SliderModel();
  WIthOutLoginProductListModel productListModel =
      WIthOutLoginProductListModel();
  Category? categoryData;
  HomeProvider? mHomeProvider;
  final TextEditingController _searchController = TextEditingController();
  List<SwipeWidgetModel> introWidgetsList = [];
  final ValueNotifier<double> _notifier = ValueNotifier<double>(0);
  var currentPageValue = 0;
  int? _previousPage;
  var _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.9,
    )..addListener(_onScroll);

    _previousPage = _pageController.initialPage;
    callProductCategoryListApi();
    callProductListApi();
    callSliderApi();
    super.initState();
  }

  void _onScroll() {
    if (_pageController.page!.toInt() == _pageController.page) {
      _previousPage = _pageController.page!.toInt();
    }
    _notifier.value = (_pageController.page! - _previousPage!);
  }

  @override
  Widget build(BuildContext context) {
    mHomeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: mHomeProvider!.isRequestSend,
        child: Scaffold(
          backgroundColor: AppColors.colorWhite,
          drawer: const BuyerSideMenu(),
          body: getBody(),
        ),
      ),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          productCategoryModel.results != null
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.colorWhite,
                      border:
                          Border.all(color: AppColors.colorBorder, width: 1.0),
                      borderRadius: const BorderRadius.all(Radius.circular(6)),
                    ),
                    child: DropdownButton<Category>(
                      hint: categoryData == null
                          ? const Text('Select Category')
                          : Text(categoryData!.categoryName!),
                      underline: Container(),
                      isExpanded: true,
                      isDense: true,
                      items: productCategoryModel.results!.category!
                          .map((Category value) {
                        return DropdownMenuItem<Category>(
                          value: value,
                          child: Text(value.categoryName!),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          categoryData = newValue;
                        });
                      },
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                border: Border.all(color: AppColors.colorBorder, width: 1.0),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      textInputAction: TextInputAction.search,
                      style: AppFont.NUNITO_REGULAR_BLACK_14,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      onChanged: (value) {
                        // onSearchTextChanged(value);
                      },
                      decoration: InputDecoration(
                          isDense: true,
                          hintText: 'Search Product',
                          hintStyle: AppFont.NUNITO_REGULAR_BLACK_14,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          border: InputBorder.none),
                    ),
                  ),
                  const Icon(
                    Icons.search,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          productListModel.results != null &&
                  productListModel.results!.product!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  child: SizedBox(
                    height: 206,
                    child: ListView.builder(
                      itemCount: introWidgetsList.length,
                      scrollDirection: Axis.horizontal,
                      // onPageChanged: (int page) {
                      //   getChangedPageAndMoveBar(page);
                      // },
                      // controller: _pageController,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.colorLightBlueGrey,
                                  border: Border.all(
                                      color: AppColors.colorBorder, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                ),
                                child: Image.network(
                                  introWidgetsList[index].image!,
                                  width: MediaQuery.of(context).size.width *
                                      90 /
                                      100,
                                  height: 204,
                                  fit: BoxFit.fill,
                                  errorBuilder: (BuildContext? context,
                                      Object? exception,
                                      StackTrace? stackTrace) {
                                    return Image.asset(
                                      APPImages.icError,
                                      width:
                                          MediaQuery.of(context!).size.width *
                                              90 /
                                              100,
                                      height: 204,
                                    );
                                  },
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 18),
          productListModel.results != null &&
                  productListModel.results!.product!.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                        productListModel.results!.product!.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: InkWell(
                          onTap: () {
                            NavKey.navKey.currentState!.pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (_) => BuyerHomeScreenNavigation(
                                      selectedIndex: 1,
                                    )),
                                    (route) => false);
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.colorLightBlueGrey,
                                  border: Border.all(
                                      color: AppColors.colorBorder, width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                                child: Column(
                                  children: [
                                    Image.network(
                                      productListModel
                                          .results!.product![index].image1!,
                                      fit: BoxFit.fill,
                                      height: 88,
                                      width: 129,
                                      errorBuilder: (BuildContext? context,
                                          Object? exception,
                                          StackTrace? stackTrace) {
                                        return Image.asset(
                                          APPImages.icError,
                                          height: 88,
                                          width: 129,
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(productListModel.results!
                                          .product![index].productName!),
                                    )
                                  ],
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void getChangedPageAndMoveBar(int page) {
    currentPageValue = page;
    setState(() {
      _notifier.value = 0;
    });
  }

  callProductListApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      mHomeProvider!.productListWithOutSellerId().then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              productListModel = WIthOutLoginProductListModel.fromJson(value);
              for (var item in productListModel.results!.product!) {
                introWidgetsList.add(SwipeWidgetModel(image: item.image1!));
              }
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

  callSliderApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      mHomeProvider!.sliders().then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              sliderModel = SliderModel.fromJson(value);
              for (var item in sliderModel.results!.slides!) {
                introWidgetsList.add(SwipeWidgetModel(image: item.image!));
              }
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

  callProductCategoryListApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      mHomeProvider!.getProductCategory().then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              productCategoryModel = ProductCategoryModel.fromJson(value);
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
