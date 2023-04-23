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
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.57,
          backgroundColor: const Color(0xFFFFFFFF),
          // ignore: sort_child_properties_last
          child: ListView(
            children: [
              UiHelper.verticalSpace(vspace: Spacing.large),
              ListTile(
                  leading: SizedBox(
                    height: 120,
                    child: Container(
                      width: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6BA444),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(0, 8),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          //BoxShadow
                        ],
                      ),
                      child: Column(
                        children: [
                          UiHelper.verticalSpace(vspace: Spacing.xsmall),
                          const Icon(
                            Icons.account_circle,
                            color: Color(0xFFFFFFFF),
                            size: 45,
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Text(profileModel.name ?? ' ',
                      style: const TextStyle(
                          color: Color(0xFF6BA444),
                          fontFamily: "Cabin",
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                  onTap: (() {
                    Navigator.pushNamed(context, '/eighth');
                  })),
              UiHelper.verticalSpace(vspace: Spacing.large),
              const Divider(
                thickness: 1.2, // thickness of the line
                indent: 0, // empty space to the leading edge of divider.
                endIndent:
                    0, // empty space to the trailing edge of the divider.
                color: Color(
                    0xFF6BA444), // The color to use when painting the line.
                height: 0, // The divider's height extent.
              ),
              ListTile(
                  leading: const Icon(
                    Icons.home,
                    color: Color(0xFF6BA444),
                    size: 26,
                  ),
                  title: const Text('Home',
                      style: TextStyle(
                          color: Color(0xFF6BA444),
                          fontFamily: "Cabin",
                          fontSize: 17,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                  onTap: (() {
                    Navigator.pushNamed(context, '/fourth');
                  })),
              ListTile(
                  leading: const Icon(
                    Icons.inventory,
                    color: Color(0xFF6BA444),
                    size: 26,
                  ),
                  title: const Text('Orders',
                      style: TextStyle(
                          color: Color(0xFF6BA444),
                          fontFamily: "Cabin",
                          fontSize: 17,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                  onTap: (() {
                    Navigator.pushNamed(context, '/seventh');
                  })),
              const Divider(
                thickness: 1.2, // thickness of the line
                indent: 0, // empty space to the leading edge of divider.
                endIndent:
                    0, // empty space to the trailing edge of the divider.
                color: Color(
                    0xFF6BA444), // The color to use when painting the line.
                height: 0.001, // The divider's height extent.
              ),
              ListTile(
                  leading: const Icon(
                    Icons.shopping_cart_rounded,
                    color: Color(0xFF6BA444),
                    size: 26,
                  ),
                  title: const Text('Cart',
                      style: TextStyle(
                          color: Color(0xFF6BA444),
                          fontFamily: "Cabin",
                          fontSize: 17,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                  onTap: (() {
                    Navigator.pushNamed(context, '/eleventh');
                  })),
              ListTile(
                  leading: const Icon(
                    Icons.help_outlined,
                    color: Color(0xFF6BA444),
                    size: 26,
                  ),
                  title: const Text('Help',
                      style: TextStyle(
                          color: Color(0xFF6BA444),
                          fontFamily: "Cabin",
                          fontSize: 17,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600)),
                  onTap: (() {
                    Navigator.pushNamed(context, '/tenth');
                  })),
              const Divider(
                thickness: 1.2, // thickness of the line
                indent: 0, // empty space to the leading edge of divider.
                endIndent:
                    0, // empty space to the trailing edge of the divider.
                color: Color(
                    0xFF6BA444), // The color to use when painting the line.
                height: 0.001, // The divider's height extent.
              ),
            ],
          ),
        ),
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
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: SizedBox(
                          height: UiHelper.displayHeight(context) * 0.85,
                          width: UiHelper.displayWidth(context) * 1,
                          child: CustomPaint(
                            painter: CurvePainter(),
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 16),
                                  child: Text(
                                    hell.companyName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFFFFFFF),
                                        fontSize: width * 0.080),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 22),
                                  child: Text(
                                    profileModel.name ?? ' ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Mulish",
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFFFFFFFF),
                                        fontSize: width * 0.055),
                                  ),
                                ),
                                UiHelper.verticalSpace(vspace: Spacing.large),
                                Container(
                                  height: 437,
                                  width: UiHelper.displayWidth(context) * 0.83,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
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
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(
                                                Icons.location_on_rounded,
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.065,
                                                color: const Color(0xFF6BA444),
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
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF222222),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                                  hspace: Spacing.xxlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xsmall),
                                              Align(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  width: width * 0.65,
                                                  height: height * 0.03,
                                                  child: Text(
                                                    hell.address ?? ' ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.1,
                                                        fontFamily:
                                                            "SignikaNegative-Bold",
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.000090,
                                      ),
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.medium),
                                      Row(
                                        children: [
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.large),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(
                                                Icons.mail_rounded,
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.065,
                                                color: const Color(0xFF6BA444),
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
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF222222),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                                  hspace: Spacing.xxlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xsmall),
                                              Align(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  width: width * 0.65,
                                                  height: height * 0.03,
                                                  child: Text(
                                                    profileModel.email ?? ' ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.1,
                                                        fontFamily:
                                                            "SignikaNegative-Bold",
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.000090,
                                      ),
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.medium),
                                      Row(
                                        children: [
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.large),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(
                                                Icons.phone_rounded,
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.065,
                                                color: const Color(0xFF6BA444),
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
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF222222),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                                  hspace: Spacing.xxlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xsmall),
                                              Align(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  width: width * 0.65,
                                                  height: height * 0.03,
                                                  child: Text(
                                                    profileModel.phone ?? ' ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.1,
                                                        fontFamily:
                                                            "SignikaNegative-Bold",
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.000090,
                                      ),
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.medium),
                                      Row(
                                        children: [
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.large),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(
                                                Icons.wallet_rounded,
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.065,
                                                color: const Color(0xFF6BA444),
                                              )),
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.medium),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Credit Balance',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  letterSpacing: 0.3,
                                                  fontFamily: "KumbhSans",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF222222),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                                  hspace: Spacing.xxlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xsmall),
                                              Align(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  width: width * 0.65,
                                                  height: height * 0.03,
                                                  child: Text(
                                                    "Rs: $creditBalance",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.1,
                                                        fontFamily:
                                                            "SignikaNegative-Bold",
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.000090,
                                      ),
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.medium),
                                      Row(
                                        children: [
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.large),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(
                                                Icons.insights_rounded,
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.065,
                                                color: const Color(0xFF6BA444),
                                              )),
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.medium),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Credit Limit',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  letterSpacing: 0.3,
                                                  fontFamily: "KumbhSans",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF222222),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                                  hspace: Spacing.xxlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xsmall),
                                              Align(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  width: width * 0.65,
                                                  height: height * 0.03,
                                                  child: Text(
                                                    "Rs: ${hell.creditLimit ?? ' '}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.1,
                                                        fontFamily:
                                                            "SignikaNegative-Bold",
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.000090,
                                      ),
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.medium),
                                      Row(
                                        children: [
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.large),
                                          Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Icon(
                                                Icons.currency_rupee_rounded,
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.065,
                                                color: const Color(0xFF6BA444),
                                              )),
                                          UiHelper.horizontaSpace(
                                              hspace: Spacing.medium),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Amount Paid',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  letterSpacing: 0.3,
                                                  fontFamily: "KumbhSans",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFF222222),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                                  hspace: Spacing.xxlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xlarge),
                                              UiHelper.horizontaSpace(
                                                  hspace: Spacing.xsmall),
                                              Align(
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  width: width * 0.65,
                                                  height: height * 0.03,
                                                  child: Text(
                                                    "Rs: ${hell.paidAmt ?? ' '}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        letterSpacing: 0.1,
                                                        fontFamily:
                                                            "SignikaNegative-Bold",
                                                        fontWeight:
                                                            FontWeight.w400,
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
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xFF6BA444);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.36);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2.8, size.width, size.height * 0.36);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
