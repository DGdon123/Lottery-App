// ignore_for_file: unnecessary_new

import 'dart:core';

import 'package:ecommerce/NetworkHandler.dart';
import 'package:ecommerce/models/pay.dart';
import 'package:ecommerce/services/epi.dart';
import 'package:ecommerce/services/help.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:ecommerce/services/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ecommerce/models/profile.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'models/accounting.dart';

class FourthRoute extends StatefulWidget {
  const FourthRoute({Key? key}) : super(key: key);

  @override
  State<FourthRoute> createState() => _FourthRouteState();
}

class _FourthRouteState extends State<FourthRoute> {
  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var size, height, width;
  var circular = true;
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Network network = Network();
  Help help = Help();
  List<Pay> datalist = [];
  List<Pay> payed = [];
  NetworkHandler networkHandler = NetworkHandler();
  Account hell = Account(
      creditBalance: '', discount: '0', deliveryCharge: 0, companyName: '');

  Post profileModel = Post();
  String creditBalance = "0.00";

  @override
  void initState() {
    super.initState();
    dataaas();
    fetchData();
    //rowing();
    hun();
  }

  void fetchData() async {
    var response = await networkHandler.get("user");
    print(response);

    setState(() {
      profileModel = Post.fromJson(response);
      print(profileModel);
      circular = false;
    });
  }

  dataaas() async {
    var res = await networkHandler.get("user");
    print(res);
    profileModel = Post.fromJson(res);
    print(profileModel);
    var response = await network.get("user/${profileModel.id}/account");
    print(response);

    setState(() {
      hell = Account.fromJson(response);
      print(hell);

      circular = false;
    });
  }

  /*rowing() async {
    var res = await networkHandler.get("user");
    print(res);
    profileModel = Post.fromJson(res);
    print(profileModel);
    var response = await help.get("user/7/payment");
    print(response);

    setState(() {
      heaven = Payment.fromJson(response);
      print(heaven);

      circular = false;
    });
  }*/

  hun() async {
    Payment tree = await ming();

    setState(() {
      datalist = tree.data;
      payed = [datalist.last];
    });
  }

  @override
  Widget build(BuildContext context) {
    if (double.tryParse(hell.creditBalance) != null) {
      creditBalance = double.parse(hell.creditBalance).toStringAsFixed(2);
    }
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF6BA444),
          centerTitle: true,
          title: const Text('Profile',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.w700,
              )),
          iconTheme: const IconThemeData(
            size: 30, //change size on your need
            color: Color(0xFFFFFFFF), //change color on your need
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 22,
                ),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    onConfirmBtnTap: () {
                      Get.toNamed('/third');
                    },
                    type: QuickAlertType.confirm,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    confirmBtnColor: Colors.green,
                  );
                },
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: Center(
            child: circular
                ? (Container(
                    child: LoadingAnimationWidget.discreteCircle(
                      secondRingColor: const Color(0xFF6BA444),
                      thirdRingColor: const Color(0xFFFCD62D),
                      size: UiHelper.displayWidth(context) * 0.08,
                      color: const Color(0xFFFCD62D),
                    ),
                  ))
                : Column(children: [
                    Expanded(
                        child: SingleChildScrollView(
                            child: SizedBox(
                                height: UiHelper.displayHeight(context) * 0.85,
                                width: UiHelper.displayWidth(context) * 1,
                                child: CustomPaint(
                                  painter: CurvePainter(),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.001,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        width: UiHelper.displayWidth(context) *
                                            0.3,
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.15,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                "images/logos.png",
                                              ),
                                              fit: BoxFit.fitWidth),
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80)),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.025,
                                      ),
                                      Text(
                                        profileModel.name ?? ' ',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFFFFFFFF),
                                            fontSize: width * 0.080),
                                      ),
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.large),
                                      Container(
                                        height: 280,
                                        width: UiHelper.displayWidth(context) *
                                            0.83,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFFFFFF),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10.0)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.2),
                                              offset: const Offset(0, 8),
                                              blurRadius: 10.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                            //BoxShadow
                                          ],
                                        ),
                                        child: Column(
                                          children: [
                                            UiHelper.verticalSpace(
                                                vspace: Spacing.medium),
                                            Row(
                                              children: [
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.large),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Icon(
                                                      Icons.location_on_rounded,
                                                      size:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.065,
                                                      color: const Color(
                                                          0xFF6BA444),
                                                    )),
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.medium),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Address',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.3,
                                                        fontFamily: "KumbhSans",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xFF222222),
                                                        fontSize: UiHelper
                                                                .displayWidth(
                                                                    context) *
                                                            0.043),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    UiHelper.horizontaSpace(
                                                        hspace:
                                                            Spacing.xxlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xsmall),
                                                    Align(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        width: width * 0.65,
                                                        height: height * 0.03,
                                                        child: Text(
                                                          hell.address ?? ' ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  0.1,
                                                              fontFamily:
                                                                  "SignikaNegative-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: const Color(
                                                                  0xFFA6AEB0),
                                                              fontSize: UiHelper
                                                                      .displayWidth(
                                                                          context) *
                                                                  0.04),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.000090,
                                            ),
                                            UiHelper.verticalSpace(
                                                vspace: Spacing.medium),
                                            Row(
                                              children: [
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.large),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Icon(
                                                      Icons.mail_rounded,
                                                      size:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.065,
                                                      color: const Color(
                                                          0xFF6BA444),
                                                    )),
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.medium),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Email Address',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.3,
                                                        fontFamily: "KumbhSans",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xFF222222),
                                                        fontSize: UiHelper
                                                                .displayWidth(
                                                                    context) *
                                                            0.043),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    UiHelper.horizontaSpace(
                                                        hspace:
                                                            Spacing.xxlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xsmall),
                                                    Align(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        width: width * 0.65,
                                                        height: height * 0.03,
                                                        child: Text(
                                                          profileModel.email ??
                                                              ' ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  0.1,
                                                              fontFamily:
                                                                  "SignikaNegative-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: const Color(
                                                                  0xFFA6AEB0),
                                                              fontSize: UiHelper
                                                                      .displayWidth(
                                                                          context) *
                                                                  0.04),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.000090,
                                            ),
                                            UiHelper.verticalSpace(
                                                vspace: Spacing.medium),
                                            Row(
                                              children: [
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.large),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Icon(
                                                      Icons.phone_rounded,
                                                      size:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.065,
                                                      color: const Color(
                                                          0xFF6BA444),
                                                    )),
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.medium),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Mobile Number',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.3,
                                                        fontFamily: "KumbhSans",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xFF222222),
                                                        fontSize: UiHelper
                                                                .displayWidth(
                                                                    context) *
                                                            0.043),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    UiHelper.horizontaSpace(
                                                        hspace:
                                                            Spacing.xxlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xsmall),
                                                    Align(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        width: width * 0.65,
                                                        height: height * 0.03,
                                                        child: Text(
                                                          profileModel.phone ??
                                                              ' ',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  0.1,
                                                              fontFamily:
                                                                  "SignikaNegative-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: const Color(
                                                                  0xFFA6AEB0),
                                                              fontSize: UiHelper
                                                                      .displayWidth(
                                                                          context) *
                                                                  0.04),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: UiHelper.displayHeight(
                                                      context) *
                                                  0.000090,
                                            ),
                                            UiHelper.verticalSpace(
                                                vspace: Spacing.medium),
                                            Row(
                                              children: [
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.large),
                                                Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Icon(
                                                      Icons.wallet_rounded,
                                                      size:
                                                          UiHelper.displayWidth(
                                                                  context) *
                                                              0.065,
                                                      color: const Color(
                                                          0xFF6BA444),
                                                    )),
                                                UiHelper.horizontaSpace(
                                                    hspace: Spacing.medium),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    'Gift Budget',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.3,
                                                        fontFamily: "KumbhSans",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xFF222222),
                                                        fontSize: UiHelper
                                                                .displayWidth(
                                                                    context) *
                                                            0.043),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    UiHelper.horizontaSpace(
                                                        hspace:
                                                            Spacing.xxlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xlarge),
                                                    UiHelper.horizontaSpace(
                                                        hspace: Spacing.xsmall),
                                                    Align(
                                                      child: Container(
                                                        alignment: Alignment
                                                            .bottomLeft,
                                                        width: width * 0.65,
                                                        height: height * 0.03,
                                                        child: Text(
                                                          "Rs: ${hell.creditLimit ?? ' '}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              letterSpacing:
                                                                  0.1,
                                                              fontFamily:
                                                                  "SignikaNegative-Bold",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: const Color(
                                                                  0xFFA6AEB0),
                                                              fontSize: UiHelper
                                                                      .displayWidth(
                                                                          context) *
                                                                  0.04),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))))
                  ])));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xFF6BA444);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2.035, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
