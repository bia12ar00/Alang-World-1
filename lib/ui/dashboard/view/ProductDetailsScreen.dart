import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sb_portal/ui/auth/model/CommonModel.dart';
import 'package:sb_portal/ui/dashboard/model/AddProductModel.dart';
import 'package:sb_portal/ui/dashboard/model/ProductListModel.dart';
import 'package:sb_portal/ui/dashboard/provider/HomeProvider.dart';
import 'package:sb_portal/ui/dashboard/view/EditProductScreen.dart';
import 'package:sb_portal/utils/NavKey.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_images.dart';
import 'package:sb_portal/utils/app_string.dart';
import 'package:sb_portal/utils/app_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;

  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentIndex = 0;
  List<String> listOfImages = [];
  HomeProvider? mHomeProvider;
  String? displaySelectedImages;

  @override
  void initState() {
    if (widget.product!.image1 != null) {
      listOfImages.add(widget.product!.image1!);
      displaySelectedImages = widget.product!.image1!;
    }
    if (widget.product!.image2 != null && widget.product!.image2!.isNotEmpty) {
      listOfImages.add(widget.product!.image2!);
    }
    if (widget.product!.image3 != null && widget.product!.image3!.isNotEmpty) {
      listOfImages.add(widget.product!.image3!);
    }
    if (widget.product!.image4 != null && widget.product!.image4!.isNotEmpty) {
      listOfImages.add(widget.product!.image4!);
    }
    if (widget.product!.image5 != null && widget.product!.image5!.isNotEmpty) {
      listOfImages.add(widget.product!.image5!);
    }
    if (widget.product!.image6 != null && widget.product!.image6!.isNotEmpty) {
      listOfImages.add(widget.product!.image6!);
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mHomeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 80,
            flexibleSpace: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    color: Colors.black,
                    icon: const Icon(Icons.arrow_back_outlined),
                    onPressed: () {
                      //Scaffold.of(context).openDrawer();
                    },
                  ),
                  Expanded(
                      child: Image.asset(
                    APPImages.IC_SPLASH_LOGO,
                    height: 73,
                    width: 73,
                  )),
                  IconButton(
                    color: Colors.black,
                    icon: const Icon(
                      Icons.delete,
                      size: 30,
                    ),
                    onPressed: delete,
                  ),
                ],
              ),
            ),
            backgroundColor: AppColors.colorWhite,
            elevation: 0.0),
        backgroundColor: AppColors.colorWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: CarouselSlider.builder(
                    itemCount: listOfImages.length,
                    options: CarouselOptions(
                        enlargeCenterPage: true,
                        height: 300,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        reverse: false,
                        aspectRatio: 5.0,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        }),
                    itemBuilder: (context, i, id) {
                      //for onTap to redirect to another screen
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                color: Colors.white,
                              )),
                          //ClipRRect for image border radius
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(7),
                            child: Image.network(
                              listOfImages[i],
                              width: 500,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // child: Image.network(
                //   displaySelectedImages!,
                //   width: 300,
                //   height: 200,
                //   fit: BoxFit.fill,
                //   errorBuilder: (BuildContext? context, Object? exception,
                //       StackTrace? stackTrace) {
                //     return const Icon(
                //       Icons.error_outlined,
                //       size: 200,
                //     );
                //   },
                // ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: listOfImages.map((urlOfItem) {
                  int index = listOfImages.indexOf(urlOfItem);
                  final isSelected = _currentIndex == index;
                  return Container(
                    width: isSelected ? 7.0 : 5,
                    height: isSelected ? 7.0 : 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product!.productName!,
                style: TextStyle(color: Colors.black.withOpacity(0.9), fontFamily: 'RobotRegular', fontWeight: FontWeight.w500, fontSize: 22),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product!.categoryname!,
                    style: TextStyle(color: Colors.black.withOpacity(0.9), fontFamily: 'RobotRegular'),
                  ),
                  InkWell(
                    onTap: () {
                      //  EditProductScreen
                      NavKey.navKey.currentState!.push(
                        MaterialPageRoute(
                            builder: (_) => EditProductScreen(
                                  product: widget.product,
                                )),
                      );
                    },
                    child: Container(
                      height: 25,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(color: Colors.black.withOpacity(0.9), borderRadius: BorderRadius.circular(3)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            FontAwesomeIcons.penToSquare,
                            color: Colors.white,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text("EDIT", style: TextStyle(color: Colors.white.withOpacity(0.9), fontFamily: 'RobotRegular')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              ),
              Text(
                widget.product!.description!,
                style: TextStyle(color: Colors.black.withOpacity(0.9), fontFamily: 'RobotRegular'),
              ),

              //  Row(
              //    children: [
              //      Text(
              //        'Description: ',
              //        style: AppFont.NUNITO_REGULAR_DARK_BLACK_16,
              //      ),
              //      Text(
              //        widget.product!.description!,
              //        style: AppFont.NUNITO_REGULAR_DARK_BLACK_16,
              //      ),
              //    ],
              //  ),
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
              //         child: MaterialButton(onPressed: null, child: Text('EDIT', style: AppFont.NUNITO_BOLD_WHITE_24)),
              //       ),
              //     ),
              //     onTap: () {
              //       NavKey.navKey.currentState!.push(MaterialPageRoute(
              //           builder: (_) => EditProductScreen(
              //                 product: widget.product!,
              //               )));
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  buildProductImage(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            displaySelectedImages = listOfImages[index];
          });
        },
        child: Container(
          height: 50,
          width: 80,
          decoration: BoxDecoration(
            color: AppColors.colorLightBlueGrey,
            border: Border.all(color: AppColors.colorBorder, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Image.network(
            listOfImages[index],
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  void delete() {
    AppWidgets.showConfirmationDialog(context, 'Delete Product', (MediaQuery.of(context).size.height / 80.0) * 19,
        actionLabelOne: APPStrings.NO, actionLabelTwo: APPStrings.YES, onClickActionOne: () {
      Navigator.of(context).pop();
    }, onClickActionTwo: () {
      Navigator.of(context).pop();
      callDeleteProductApi();
    });
  }

  callDeleteProductApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      mHomeProvider!.deleteProduct(widget.product!.id.toString()).then((value) {
        if (value != null) {
          try {
            CommonModel streams = CommonModel.fromJson(value);
            if (streams.response != null && streams.response == "error") {
              Fluttertoast.showToast(msg: streams.message);
            } else {
              AddProductModel addProductModel = AddProductModel.fromJson(value);
              Fluttertoast.showToast(msg: addProductModel.message!);
            }
            Navigator.of(context).pop();
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
