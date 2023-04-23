// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;
import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'dart:ui' as ui;
import 'package:pdf/pdf.dart';

import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:typed_data';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:intl/intl.dart';
import 'package:ecommerce/models/invoicemodel.dart';
import 'package:ecommerce/models/itemsmodel.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:ecommerce/services/dpi.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfwidgets;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models/cartmodel.dart';

import 'models/cookies.dart';
import 'models/customer.dart';
import 'models/invoice.dart';
import 'models/ordermodel.dart';
import 'models/ply.dart';
import 'models/profile.dart';

import 'package:http/http.dart' as http;

import 'models/supplier.dart';

class SixthRoute extends StatefulWidget {
  List<Datum> ring;
  int index;

  SixthRoute({Key? key, required this.index, required this.ring})
      : super(key: key);

  @override
  State<SixthRoute> createState() => _SixthRouteState();
}

class _SixthRouteState extends State<SixthRoute> {
  GlobalKey _globalKey = GlobalKey();
  final pdfwidgets.Document pdf = pdfwidgets.Document();
  FlutterSecureStorage storage = FlutterSecureStorage();

  Future<void> requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.location,
    ].request();
    print(statuses);
  }

  @override
  void initState() {
    super.initState();
    _buttonColor = originalButtonColor;
    hunging();
    dating();
    data();
    fetchData();
    requestPermission();
  }

  var isLoading = true;

  Uint8List? screenShot;

  List<OrderItem> ringing = [];
  List<Item> samplePosts = [];
  int serialNo = 0;
  bool _clicked = false;

  var userData = <Item>[];
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
  var screenshotController = ScreenshotController();
  String? grade;
  String? product;
  String? thickness;
  String? price;
  String? size;
  String? unit;
  var sizings, height, width;
  var prices;
  int total = 0;
  Color originalButtonColor = Color(0xFFD71B23);
  Color? _buttonColor;
  var gradeName, productName, thicknessName, sizeName;

  fetchData() async {
    Ply? dum = await getData();
    setState(() {
      gradelist = dum!.grade;
      productlist = dum.product;
      thicknesslist = dum.thickness;
      pricinglist = dum.price;
      sizinglist = dum.size;
    });
  }

  Future<void> downloadFile(String url, String filePath) async {
    Dio dio = Dio();
    try {
      var response = await dio.download(url, filePath);
      print("Download completed with status: ${response.statusCode}");
    } catch (e) {
      print("Download failed: $e");
    }
  }

  void dating() async {
    var response = await networkHandler.get("user");
    print(response);
    setState(() {
      profileModel = Post.fromJson(response);
      print(profileModel);
    });
  }

  Future<List<Item>> data() async {
    setState(() {
      isLoading = true;
    });
    var resp = await networkHandler.get("user");
    print(resp);
    profileModel = Post.fromJson(resp);
    print(profileModel);
    String? token = await storage.read(key: "token");
    final response = await http.get(
      Uri.parse(
        'https://trulam.prabidhienterprises.com/api/cart-items/${profileModel.id}',
      ),
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    print(data["cart_items"]);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      for (var index in data["cart_items"]) {
        samplePosts.add(Item.fromJson(index));
      }
      print(samplePosts);
      return samplePosts;
    } else {
      return userData;
    }
  }

  Future<List<OrderItem>> hunging() async {
    String? token = await storage.read(key: "token");
    print(widget.ring[widget.index].id);
    final response = await http.get(
      Uri.parse(
        'https://trulam.prabidhienterprises.com/api/invoice/${widget.ring[widget.index].id}',
      ),
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    print(data["order_item"]);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      for (var index in data["order_item"]) {
        ringing.add(OrderItem.fromJson(index));
      }

      return ringing;
    } else {
      return ringing;
    }
  }

  int calculateTotalPrice(List<OrderItem> ringing) {
    int total = 0;
    for (var item in ringing) {
      int price = item.cartId;
      total = price;
    }
    print(total);
    return total;
  }

  int address(List<OrderItem> ringing) {
    int total = 0;
    for (var item in ringing) {
      int price = item.cartId;
      total = price;
    }
    print(total);
    return total;
  }

  @override
  Widget build(BuildContext context) {
    sizings = MediaQuery.of(context).size;
    height = sizings.height;
    width = sizings.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD71B23),
        centerTitle: true,
        title: const Text('Order Details',
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pushNamed(context, '/seventh');
              },
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Container(
                height: UiHelper.displayHeight(context) * 0.85,
                child: Column(children: [
                  Column(
                    children: [
                      UiHelper.verticalSpace(vspace: Spacing.medium),
                      Screenshot(
                        controller: screenshotController,
                        child: Container(
                          width: width * 0.92,
                          height: height * 0.71,
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 0.8,
                                    style: BorderStyle.solid),
                              ),
                              child: Column(
                                children: [
                                  UiHelper.verticalSpace(vspace: Spacing.small),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.medium),
                                      ClipRRect(
                                        // ignore: sort_child_properties_last
                                        child: Image.asset(
                                          "images/logo.png",
                                          width: width * 0.3,
                                          height: height * 0.11,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 64),
                                        child: Column(
                                          children: [
                                            UiHelper.verticalSpace(
                                                vspace: Spacing.small),
                                            Text(
                                              "SAGUN PLY",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  height:
                                                      UiHelper.displayHeight(
                                                              context) *
                                                          0.000205,
                                                  fontFamily:
                                                      "SignikaNegative-Bold",
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFD71A21),
                                                  fontSize: width * 0.055),
                                            ),
                                            Text(
                                              "Janakpurdham, Nepal",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  height:
                                                      UiHelper.displayHeight(
                                                              context) *
                                                          0.0025,
                                                  fontFamily:
                                                      "SignikaNegative-Bold",
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFFD71A21),
                                                  fontSize: width * 0.04),
                                            ),
                                            Text(
                                              "Tel: 041- 521 640",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  height:
                                                      UiHelper.displayHeight(
                                                              context) *
                                                          0.0019,
                                                  fontFamily:
                                                      "SignikaNegative-Bold",
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xFFD71A21),
                                                  fontSize: width * 0.038),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(vspace: Spacing.small),
                                  const Divider(
                                    thickness: 1.5, // thickness of the line
                                    indent:
                                        0, // empty space to the leading edge of divider.
                                    endIndent:
                                        0, // empty space to the trailing edge of the divider.
                                    color: Color(
                                        0xFF222222), // The color to use when painting the line.
                                    height: 0.8, // The divider's height extent.
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    child: Row(children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.large),
                                      Text(
                                        "Name:",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.038),
                                      ),
                                      Text(
                                        " ${profileModel.name}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: height * 0.0016,
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.038),
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(left: 103),
                                          child: Row(
                                            children: [
                                              Text(
                                                "Date:",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "SignikaNegative-Bold",
                                                    fontWeight: FontWeight.w500,
                                                    color: Color(0xFF222222),
                                                    fontSize: width * 0.038),
                                              ),
                                              Text(
                                                " ${DateFormat('yyyy-MM-dd').format(widget.ring[widget.index].createdAt!)}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    height: height * 0.0016,
                                                    fontFamily:
                                                        "SignikaNegative-Bold",
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xFF222222),
                                                    fontSize: width * 0.038),
                                              ),
                                            ],
                                          ))
                                    ]),
                                  ),
                                  UiHelper.verticalSpace(
                                      vspace: Spacing.xsmall),
                                  Container(
                                    child: Row(
                                      children: [
                                        UiHelper.horizontaSpace(
                                            hspace: Spacing.large),
                                        Text(
                                          "Invoice Number:",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF222222),
                                              fontSize: width * 0.038),
                                        ),
                                        Text(
                                          " ${widget.ring[widget.index].id}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF222222),
                                              fontSize: width * 0.038),
                                        ),
                                      ],
                                    ),
                                  ),
                                  UiHelper.verticalSpace(
                                      vspace: Spacing.xsmall),
                                  Container(
                                    child: Row(children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.large),
                                      Text(
                                        "Invoice Status:",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.038),
                                      ),
                                      Text(
                                        " ${widget.ring[widget.index].paymentStatus}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.038),
                                      ),
                                    ]),
                                  ),
                                  UiHelper.verticalSpace(
                                      vspace: Spacing.xsmall),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.medium),
                                      Container(
                                        width: UiHelper.displayWidth(context) *
                                            0.095,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "S.N",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 1.95,
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 24, 23, 23),
                                              fontSize: width * 0.038),
                                        ),
                                      ),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.small),
                                      Container(
                                        width: UiHelper.displayWidth(context) *
                                            0.41,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Products",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              height: 1.95,
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 24, 23, 23),
                                              fontSize: width * 0.038),
                                        ),
                                      ),
                                      Container(
                                        width: UiHelper.displayWidth(context) *
                                            0.092,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Qty",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 1.95,
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 24, 23, 23),
                                              fontSize: width * 0.038),
                                        ),
                                      ),
                                      Container(
                                        width: UiHelper.displayWidth(context) *
                                            0.23,
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Amt",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 1.95,
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
                                                  255, 24, 23, 23),
                                              fontSize: width * 0.038),
                                        ),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(vspace: Spacing.small),
                                  const Divider(
                                    thickness: 2.2, // thickness of the line
                                    indent:
                                        12, // empty space to the leading edge of divider.
                                    endIndent:
                                        12, // empty space to the trailing edge of the divider.
                                    color: Color.fromARGB(255, 186, 186,
                                        189), // The color to use when painting the line.
                                    height: 0, // The divider's height extent.
                                  ),
                                  Container(
                                    height:
                                        UiHelper.displayHeight(context) * 0.24,
                                    width:
                                        UiHelper.displayWidth(context) * 0.92,
                                    alignment: Alignment.bottomCenter,
                                    child: Center(
                                      child: ListView.builder(
                                          itemCount: samplePosts.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            final serialNo = index + 1;
                                            final id = samplePosts[index].id;
                                            var gradeid =
                                                samplePosts[index].gradeId;
                                            gradeName = gradelist
                                                .firstWhere((grade) =>
                                                    grade.id == gradeid)
                                                .title;
                                            var productid =
                                                samplePosts[index].productId;
                                            productName = productlist
                                                .firstWhere((product) =>
                                                    product.id == productid)
                                                .title;
                                            var thicknessid =
                                                samplePosts[index].thicknessId;
                                            thicknessName = thicknesslist
                                                .firstWhere((thickness) =>
                                                    thickness.id == thicknessid)
                                                .title;
                                            var priceid =
                                                samplePosts[index].totalAmt;
                                            var sizeid =
                                                samplePosts[index].sizeId;
                                            sizeName = sizinglist
                                                .firstWhere(
                                                    (size) => size.id == sizeid)
                                                .title;
                                            prices =
                                                samplePosts[index].totalAmt;

                                            if (index != null &&
                                                ringing.length > 0) {
                                              for (int i = 0;
                                                  i < ringing.length;
                                                  i++) {
                                                if (ringing[i].cartId == id) {
                                                  return isLoading
                                                      ? const CircularProgressIndicator()
                                                      : SafeArea(
                                                          child: Column(
                                                              children: <
                                                                  Widget>[
                                                              ListTile(
                                                                title: Column(
                                                                  children: [
                                                                    UiHelper.verticalSpace(
                                                                        vspace:
                                                                            Spacing.xsmall),
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                UiHelper.displayWidth(context) * 0.095,
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              ((serialNo + 1) - (serialNo)).toString(),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 24, 23, 23), fontSize: width * 0.035),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                              height: UiHelper.displayHeight(context) * 0.16,
                                                                              width: UiHelper.displayWidth(context) * 0.41,
                                                                              alignment: Alignment.topLeft,
                                                                              child: Column(children: [
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    gradeName,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(height: 0, fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 24, 23, 23), fontSize: width * 0.035),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    productName,
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(height: 1.95, fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 24, 23, 23), fontSize: width * 0.035),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "Thickness: $thicknessName",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(height: 1.95, fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 41, 41, 41), fontSize: width * 0.035),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "Size: $sizeName",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(height: 1.95, fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 41, 41, 41), fontSize: width * 0.035),
                                                                                  ),
                                                                                ),
                                                                                Align(
                                                                                  alignment: Alignment.topLeft,
                                                                                  child: Text(
                                                                                    "Unit:${samplePosts[index].unit.toString()}",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(height: 1.95, fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 41, 41, 41), fontSize: width * 0.035),
                                                                                  ),
                                                                                ),
                                                                              ])),
                                                                          Container(
                                                                            width:
                                                                                UiHelper.displayWidth(context) * 0.092,
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              samplePosts[index].quantity.toString(),
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 24, 23, 23), fontSize: width * 0.035),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                UiHelper.displayWidth(context) * 0.23,
                                                                            alignment:
                                                                                Alignment.topLeft,
                                                                            child:
                                                                                Text(
                                                                              "Rs: ${samplePosts[index].totalAmt.toStringAsFixed(0)}",
                                                                              textAlign: TextAlign.center,
                                                                              style: TextStyle(fontFamily: "SignikaNegative-Bold", fontWeight: FontWeight.w500, color: Color.fromARGB(255, 24, 23, 23), fontSize: width * 0.035),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    UiHelper.verticalSpace(
                                                                        vspace:
                                                                            Spacing.small),
                                                                    Container(
                                                                      width:
                                                                          UiHelper.displayWidth(context) *
                                                                              1,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          186,
                                                                          186,
                                                                          189),
                                                                      height: UiHelper.displayHeight(
                                                                              context) *
                                                                          0.003,
                                                                    ),
                                                                    UiHelper.verticalSpace(
                                                                        vspace:
                                                                            Spacing.xsmall),
                                                                  ],
                                                                ),
                                                              )
                                                            ]));
                                                }
                                              }
                                            }

                                            return Container();
                                          }),
                                    ),
                                  ),
                                  Container(
                                    width: UiHelper.displayWidth(context) * 1,
                                    color: Color.fromARGB(255, 186, 186, 189),
                                    height:
                                        UiHelper.displayHeight(context) * 0.003,
                                  ),
                                  UiHelper.verticalSpace(
                                      vspace: Spacing.xsmall),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      Text(
                                        "Subtotal:",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF71828a),
                                            fontSize: width * 0.035),
                                      ),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xsmall),
                                      Container(
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.02,
                                        child: Text(
                                          "Rs: ${widget.ring[widget.index].totalAmt!}",
                                          style: TextStyle(
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: width * 0.035),
                                        ),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(vspace: Spacing.small),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.small),
                                      Text(
                                        "Delivery Fee:",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF71828a),
                                            fontSize: width * 0.035),
                                      ),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xsmall),
                                      Container(
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.02,
                                        child: Text(
                                          "Rs: ${widget.ring[widget.index].deliveryCharge!.toInt()}",
                                          style: TextStyle(
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: width * 0.035),
                                        ),
                                      ),
                                    ],
                                  ),
                                  UiHelper.verticalSpace(vspace: Spacing.small),
                                  Row(children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xxlarge),
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xxlarge),
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xsmall),
                                    Text(
                                      "Discounted Amount:",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "SignikaNegative-Bold",
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF71828a),
                                          fontSize: width * 0.035),
                                    ),
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xsmall),
                                    Container(
                                      height: UiHelper.displayHeight(context) *
                                          0.02,
                                      child: Text(
                                        "Rs: ${widget.ring[widget.index].discountAmt!.toInt()}",
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: width * 0.035),
                                      ),
                                    ),
                                  ]),
                                  UiHelper.verticalSpace(
                                      vspace: Spacing.xsmall),
                                  Container(
                                    width: UiHelper.displayWidth(context) * 1,
                                    color: Color.fromARGB(255, 186, 186, 189),
                                    height:
                                        UiHelper.displayHeight(context) * 0.003,
                                  ),
                                  UiHelper.verticalSpace(
                                      vspace: Spacing.xsmall),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xxlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.medium),
                                      Text(
                                        "Order Total:",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: width * 0.035),
                                      ),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xsmall),
                                      Container(
                                        height:
                                            UiHelper.displayHeight(context) *
                                                0.02,
                                        child: Text(
                                          "Rs: ${(widget.ring[widget.index].discountAmt!.toInt() + int.parse(widget.ring[widget.index].totalAmt!)) - (widget.ring[widget.index].deliveryCharge!.toInt())}",
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: width * 0.035),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      )
                    ],
                  ),
                  UiHelper.verticalSpace(vspace: Spacing.medium),
                  Container(
                    height: height * 0.065,
                    width: width * 0.88,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFD71B23),

                          shape: RoundedRectangleBorder(
                              //to set border radius to button
                              borderRadius: BorderRadius.circular(
                                  3)), //background color of button
                        ),
                        child: Text(
                          "Print",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            height: UiHelper.displayHeight(context) * 0.001,
                            fontFamily: "ZenKakuGothicAntique",
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: UiHelper.displayWidth(context) * 0.055,
                          ),
                        ),
                        onPressed: () async {
                          final uint8List =
                              await screenshotController.capture();
                          String tempPath =
                              (await getTemporaryDirectory()).path;
                          String fileName = "myFile";
                          if (await Permission.storage.request().isGranted &&
                              await Permission.location.request().isGranted) {
                            File file =
                                await File('$tempPath/$fileName.png').create();
                            file.writeAsBytesSync(uint8List!.toList());
                            await Share.shareFiles([file.path]);
                          }
                          setState(() {
                            _clicked = true;
                            _buttonColor = Color(0xFFD71B23);
                          });
                          await Future.delayed(Duration(seconds: 3));
                          setState(() {
                            _clicked = false;
                            _buttonColor = Color(0xFFD71B23);
                          });
                        }),
                  ),
                ]),
              ),
      ),
    );
  }

  String rolex(List<Datum> ring) {
    String? total;
    for (var item in ring) {
      String? price = item.orderId;
      total = price!;
    }
    return total.toString();
  }
}
