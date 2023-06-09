// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import 'package:ecommerce/NetworkHandler.dart';

import 'package:ecommerce/services/bpi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ecommerce/models/cartmodel.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cart_provider.dart';
import 'models/ply.dart';
import 'models/profile.dart';

class FourthScreen extends StatefulWidget {
  const FourthScreen({Key? key}) : super(key: key);

  @override
  State<FourthScreen> createState() => _FourthScreenState();
}

class _FourthScreenState extends State<FourthScreen> {
  Widget buildButton({
    required String title,
    required String text,
    required String leadingImage,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Image.asset(
              leadingImage,
              height: 50,
              width: 50,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 5),
                Text(text),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final storage = const FlutterSecureStorage();
  final int _cartCount = 0;
  List<Cart> quantity = [];
  List<Grade> gradelist = [];
  List<Product> templist = [];
  List<Product> productlist = [];
  List<Thickness> thicklist = [];
  List<Thickness> thicknesslist = [];
  List<Price> pricelist = [];
  List<Price> pricinglist = [];
  List<Size> sizelist = [];
  List<Size> sizinglist = [];
  var units = ['Select Unit', 'ft', 'mtr'];
  String uni = 'Select Unit';
  String? grade;
  String? product;
  String? thickness;
  String? price;
  String? size;
  String? unit;
  var user = TextEditingController();
  var grading = TextEditingController();
  var products = TextEditingController();
  var thicknessing = TextEditingController();
  var pricing = TextEditingController();
  var prices = TextEditingController();
  var sizing = TextEditingController();
  var quantitative = TextEditingController();
  var uniting = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  CartModel cartModel = CartModel();
  var sizings, height, width;
  Color originalButtonColor = const Color(0xFF6BA444);
  Color? _buttonColor;

  Post profileModel = Post();
  var isLoading = true;

  @override
  void initState() {
    super.initState();
    dating();
    fetchData();
  }

  void dating() async {
    var response = await networkHandler.get("user");
    print(response);
    setState(() {
      profileModel = Post.fromJson(response);
      print(profileModel);
    });
  }

  void _registration() async {
    var data = {
      "user_id": profileModel.id,
      "grade_id": grading.text.trim(),
      "product_id": products.text.trim(),
      "thickness_id": thicknessing.text.trim(),
      "size_id": sizing.text.trim(),
      "quantity": quantitative.text.trim(),
      "unit": uniting.text.trim()
    };
    print(data);
    var res = await Api().postData(data, 'cart/store');
    var body = json.decode(res.body);
    print(body);

    if (body['success']) {
      showDialogBox(true);
      Provider.of<CartModel>(context, listen: false).updateCartCount(
        Provider.of<CartModel>(context, listen: false).cartCount! + 1,
      );
    } else {
      showDialogBox(false);
      Provider.of<CartModel>(context, listen: false).updateCartCount(
        Provider.of<CartModel>(context, listen: false).cartCount! - 1,
      );
    }
  }

  void showDialogBox(bool isSuccessful) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xFF6BA444),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: isSuccessful
                ? Text(
                    "Success",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Cabin",
                      fontSize: width * 0.058,
                    ),
                  )
                : const Text("Unsuccessful"),
            content: isSuccessful
                ? SizedBox(
                    height: UiHelper.displayHeight(context) * 0.122,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Successfully added to cart!!!",
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Cabin",
                            fontSize: width * 0.053,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 17, top: 22),
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                ),
                                child: Text("Place Again",
                                    style: TextStyle(
                                      color: const Color(0xFF6BA444),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Cabin",
                                      fontSize: width * 0.04,
                                    )),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/fourth');
                                },
                              ),
                              UiHelper.horizontaSpace(hspace: Spacing.xxlarge),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFFFFF),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/eleventh');
                                },
                                child: Text("Close",
                                    style: TextStyle(
                                      color: const Color(0xFF6BA444),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Cabin",
                                      fontSize: width * 0.04,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    height: 95,
                    child: Column(
                      children: <Widget>[
                        const Text("Please fill up all the fields!!!"),
                        Container(
                          margin: const EdgeInsets.only(left: 35, top: 7),
                          child: Row(
                            children: [
                              ElevatedButton(
                                child: const Text("Close"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ));
      },
    );
  }

  fetchData() async {
    Ply? dum = await getData();
    setState(() {
      gradelist = dum!.grade;
      productlist = dum.product;
      thicknesslist = dum.thickness;
      pricinglist = dum.price;
      sizinglist = dum.size;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final successAlert = buildButton(
      onTap: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Transaction Completed Successfully!',
          autoCloseDuration: const Duration(seconds: 2),
        );
      },
      title: 'Success',
      text: 'Transaction Completed Successfully!',
      leadingImage: 'assets/success.gif',
    );

    final errorAlert = buildButton(
      onTap: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Oops...',
          text: 'Sorry, something went wrong',
          backgroundColor: Colors.black,
          titleColor: Colors.white,
          textColor: Colors.white,
        );
      },
      title: 'Error',
      text: 'Sorry, something went wrong',
      leadingImage: 'assets/error.gif',
    );

    final warningAlert = buildButton(
      onTap: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          text: 'You just broke protocol',
        );
      },
      title: 'Warning',
      text: 'You just broke protocol',
      leadingImage: 'assets/warning.gif',
    );

    final infoAlert = buildButton(
      onTap: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.info,
          text: 'Buy two, get one free',
        );
      },
      title: 'Info',
      text: 'Buy two, get one free',
      leadingImage: 'assets/info.gif',
    );

    final confirmAlert = buildButton(
      onTap: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          text: 'Do you want to logout',
          confirmBtnText: 'Yes',
          cancelBtnText: 'No',
          confirmBtnColor: Colors.white,
          backgroundColor: Colors.black,
          confirmBtnTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          barrierColor: Colors.white,
          titleColor: Colors.white,
          textColor: Colors.white,
        );
      },
      title: 'Confirm',
      text: 'Do you want to logout',
      leadingImage: 'assets/confirm.gif',
    );

    final loadingAlert = buildButton(
      onTap: () {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: 'Loading',
          text: 'Fetching your data',
        );
      },
      title: 'Loading',
      text: 'Fetching your data',
      leadingImage: 'assets/loading.gif',
    );

    final customAlert = buildButton(
      onTap: () {
        var message = '';
        QuickAlert.show(
          context: context,
          type: QuickAlertType.custom,
          barrierDismissible: true,
          confirmBtnText: 'Save',
          customAsset: 'assets/custom.gif',
          widget: TextFormField(
            decoration: const InputDecoration(
              alignLabelWithHint: true,
              hintText: 'Enter Phone Number',
              prefixIcon: Icon(
                Icons.phone_outlined,
              ),
            ),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            onChanged: (value) => message = value,
          ),
          onConfirmBtnTap: () async {
            if (message.length < 5) {
              await QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'Please input something',
              );
              return;
            }
            Navigator.pop(context);
            await Future.delayed(const Duration(milliseconds: 1000));
            await QuickAlert.show(
              context: context,
              type: QuickAlertType.success,
              text: "Phone number '$message' has been saved!.",
            );
          },
        );
      },
      title: 'Custom',
      text: 'Custom Widget Alert',
      leadingImage: 'assets/custom.gif',
    );
    sizings = MediaQuery.of(context).size;
    height = sizings.height;
    width = sizings.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'Nunito',
              fontSize: 19.2.sp,
              height: 0.16.h,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w900,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0,

        backgroundColor: const Color(0xFF6BA444),
        //  backgroundColor: const Color(0xFF6BA444),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: isLoading
            ? Container(
                child: LoadingAnimationWidget.discreteCircle(
                  secondRingColor: const Color(0xFF6BA444),
                  thirdRingColor: const Color(0xFFFCD62D),
                  size: UiHelper.displayWidth(context) * 0.08,
                  color: const Color(0xFFFCD62D),
                ),
              )
            : Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: height / 52,
                                ),
                                Row(children: [
                                  Container(
                                    width: width * 0.043,
                                  ),
                                  Text(
                                    "Full Name",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.0015,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF222222),
                                        fontSize: width * 0.034),
                                  ),
                                ]),
                                UiHelper.verticalSpace(vspace: Spacing.small),
                                Row(
                                  children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xlarge),
                                    Container(
                                      height: height / 14,
                                      width: width * 0.9,
                                      margin: const EdgeInsets.only(top: 0),
                                      child: TextFormField(
                                        controller: quantitative,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF6BA444)
                                              .withOpacity(0.2),
                                          hintText: 'Enter Customers Full Name',
                                          hintStyle: const TextStyle(
                                              height: 1,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff2222222),
                                              fontSize: 14),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1.5,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                                "SignikaNegative-Regular",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff2222222),
                                            fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: height / 52,
                                ),
                                Row(children: [
                                  Container(
                                    width: width * 0.043,
                                  ),
                                  Text(
                                    "Phone Number",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.0015,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF222222),
                                        fontSize: width * 0.034),
                                  ),
                                ]),
                                UiHelper.verticalSpace(vspace: Spacing.small),
                                Row(
                                  children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xlarge),
                                    Container(
                                      height: height / 14,
                                      width: width * 0.9,
                                      margin: const EdgeInsets.only(top: 0),
                                      child: TextFormField(
                                        controller: grading,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF6BA444)
                                              .withOpacity(0.2),
                                          hintText:
                                              'Enter Customers Phone Number',
                                          hintStyle: const TextStyle(
                                              height: 1,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff2222222),
                                              fontSize: 14),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1.5,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                                "SignikaNegative-Regular",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff2222222),
                                            fontSize: 14.7),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: height / 52,
                                ),
                                Row(children: [
                                  Container(
                                    width: width * 0.043,
                                  ),
                                  Text(
                                    "Bill Number",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.0015,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF222222),
                                        fontSize: width * 0.034),
                                  ),
                                ]),
                                UiHelper.verticalSpace(vspace: Spacing.small),
                                Row(
                                  children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xlarge),
                                    Container(
                                      height: height / 14,
                                      width: width * 0.9,
                                      margin: const EdgeInsets.only(top: 0),
                                      child: TextFormField(
                                        controller: prices,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF6BA444)
                                              .withOpacity(0.2),
                                          hintText:
                                              'Enter Customers Bill Number',
                                          hintStyle: const TextStyle(
                                              height: 1,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff2222222),
                                              fontSize: 14),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1.5,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                                "SignikaNegative-Regular",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff2222222),
                                            fontSize: 14.7),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: height / 52,
                                ),
                                Row(children: [
                                  Container(
                                    width: width * 0.043,
                                  ),
                                  Text(
                                    "Total Amount",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Roboto",
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.0015,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFF222222),
                                        fontSize: width * 0.034),
                                  ),
                                ]),
                                UiHelper.verticalSpace(vspace: Spacing.small),
                                Row(
                                  children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xlarge),
                                    Container(
                                      height: height / 14,
                                      width: width * 0.9,
                                      margin: const EdgeInsets.only(top: 0),
                                      child: TextFormField(
                                        controller: grading,
                                        maxLines: 1,
                                        cursorColor: Colors.black,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF6BA444)
                                              .withOpacity(0.2),
                                          hintText:
                                              'Enter Customers Total Bill Amount',
                                          hintStyle: const TextStyle(
                                              height: 1,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff2222222),
                                              fontSize: 14),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.4),
                                                width: 1.5,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            fontFamily:
                                                "SignikaNegative-Regular",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff2222222),
                                            fontSize: 14.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(height: height * 0.03),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.084,
                                    width: width * 0.91,
                                    child: MaterialButton(
                                      color: const Color(0xFF6BA444).withOpacity(
                                          0.75), //background color of button
                                      shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "Submit",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          height: height * 0.0012,
                                          fontFamily: "ZenKakuGothicAntique",
                                          fontWeight: FontWeight.w600,
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: width * 0.055,
                                        ),
                                      ),
                                      onPressed: () {
                                        if (grading.text.isEmpty &&
                                            pricing.text.isEmpty &&
                                            pricing.text.isEmpty &&
                                            quantitative.text.isEmpty) {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.error,
                                            confirmBtnColor:
                                                const Color(0xFF6BA444)
                                                    .withOpacity(0.75),
                                            title: 'Error',
                                            text:
                                                'Please fill up all the fields!!!',
                                          );
                                        } else {
                                          QuickAlert.show(
                                            context: context,
                                            type: QuickAlertType.success,
                                            confirmBtnColor:
                                                const Color(0xFF6BA444),
                                            text:
                                                'Transaction Completed Successfully!',
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
