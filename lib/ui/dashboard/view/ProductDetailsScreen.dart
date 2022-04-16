import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sb_portal/ui/auth/model/CommonModel.dart';
import 'package:sb_portal/ui/dashboard/model/AddProductModel.dart';
import 'package:sb_portal/ui/dashboard/model/ProductListModel.dart';
import 'package:sb_portal/ui/dashboard/provider/HomeProvider.dart';
import 'package:sb_portal/ui/dashboard/view/EditProductScreen.dart';
import 'package:sb_portal/utils/NavKey.dart';
import 'package:sb_portal/utils/app_colors.dart';
import 'package:sb_portal/utils/app_font.dart';
import 'package:sb_portal/utils/app_string.dart';
import 'package:sb_portal/utils/app_widgets.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product? product;

  const ProductDetailsScreen({Key? key, this.product}) : super(key: key);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<String> listOfImages = [];
  HomeProvider? mHomeProvider;
  String? displaySelectedImages;

  @override
  void initState() {
    if (widget.product!.image1 != null) {
      listOfImages.add(widget.product!.image1!);
      displaySelectedImages = widget.product!.image1!;
    }
    if (widget.product!.image2 != null) {
      listOfImages.add(widget.product!.image2!);
    }
    if (widget.product!.image3 != null) {
      listOfImages.add(widget.product!.image3!);
    }
    if (widget.product!.image4 != null) {
      listOfImages.add(widget.product!.image4!);
    }
    if (widget.product!.image5 != null) {
      listOfImages.add(widget.product!.image5!);
    }
    if (widget.product!.image6 != null) {
      listOfImages.add(widget.product!.image6!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mHomeProvider = Provider.of<HomeProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorWhite,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Product Details',
                      style: AppFont.NUNITO_SEMI_BOLD_BLACK_20,
                    ),
                  ),
                  InkWell(
                    child: const Icon(
                      Icons.delete,
                    ),
                    onTap: () {
                      delete();
                    },
                  ),
                ],
              ),
              Text(
                widget.product!.productName!,
                style: AppFont.NUNITO_SEMI_BOLD_BLACK_20,
              ),
              const SizedBox(height: 8),
              Text(
                widget.product!.categoryname!,
                style: AppFont.NUNITO_SEMI_BOLD_BLACK_16,
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  displaySelectedImages!,
                  width: 300,
                  height: 200,
                  fit: BoxFit.fill,
                  errorBuilder: (BuildContext? context, Object? exception, StackTrace? stackTrace) {
                    return const Icon(
                      Icons.error_outlined,
                      size: 200,
                    );
                  },
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return buildProductImage(index);
                  },
                  itemCount: listOfImages.length,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Description: ',
                    style: AppFont.NUNITO_REGULAR_DARK_BLACK_16,
                  ),
                  Text(
                    widget.product!.description!,
                    style: AppFont.NUNITO_REGULAR_DARK_BLACK_16,
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.colorOrange,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      child: MaterialButton(onPressed: null, child: Text('EDIT', style: AppFont.NUNITO_BOLD_WHITE_24)),
                    ),
                  ),
                  onTap: () {
                    NavKey.navKey.currentState!.push(MaterialPageRoute(
                        builder: (_) => EditProductScreen(
                              product: widget.product!,
                            )));
                  },
                ),
              ),
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
    AppWidgets.showConfirmationDialog(context, 'Delete Product', (MediaQuery.of(context).size.height / 100.0) * 19,
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
