// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'package:dio/dio.dart';

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

import 'models/ordermodel.dart';
import 'models/ply.dart';
import 'models/profile.dart';

import 'package:http/http.dart' as http;

class TenthRoute extends StatefulWidget {
  List<Datum> ring = [];
  int index;

  TenthRoute({Key? key, required this.index, required this.ring})
      : super(key: key);

  @override
  State<TenthRoute> createState() => _TenthRouteState();
}

class _TenthRouteState extends State<TenthRoute> {
  GlobalKey _globalKey = GlobalKey();
  final pdfwidgets.Document pdf = pdfwidgets.Document();
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    hunging();
    dating();
    data();
    fetchData();
  }

  var isLoading = true;

  Uint8List? screenShot;

  List<OrderItem> ringing = [];
  List<Item> samplePosts = [];
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
  var prices;
  int total = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text('ORDER DETAILS',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Roboto',
                fontSize: 22,
                fontWeight: FontWeight.w700,
              )),
          iconTheme: const IconThemeData(
            size: 30, //change size on your need
            color: Color.fromARGB(255, 0, 0, 0), //change color on your need
          ),
          elevation: 0,
          actions: [
            Container(
              width: 60,
              height: 10,
              padding: const EdgeInsets.only(top: 9),
              margin: const EdgeInsets.only(right: 7, bottom: 8, left: 55),
              child: ClipRRect(
                // ignore: sort_child_properties_last
                child: Image.asset(
                  "images/logs.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(children: [
                Screenshot(
                  controller: screenshotController,
                  child: Container(
                    height: 522,
                    width: 300,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Container(
                      margin: const EdgeInsets.only(top: 65),
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
                              Align(
                                alignment: Alignment.bottomLeft,
                                widthFactor: 1.5,
                                heightFactor: 1.2,
                                child: Text(
                                  "Order ID: ${widget.ring[widget.index].orderId}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "SignikaNegative-Bold",
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF7a7a7a),
                                      fontSize: 17.5),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                widthFactor: 1.46,
                                heightFactor: 0.5,
                                child: Text(
                                  "Placed on: ${DateFormat('yyyy-MM-dd hh:mm:ss').format(widget.ring[widget.index].createdAt!)}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 4.13,
                                      fontFamily: "SignikaNegative-Bold",
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF71828a),
                                      fontSize: 13.5),
                                ),
                              ),
                              const Divider(
                                thickness: 2.2, // thickness of the line
                                indent:
                                    0, // empty space to the leading edge of divider.
                                endIndent:
                                    0, // empty space to the trailing edge of the divider.
                                color: Color.fromARGB(255, 186, 186,
                                    189), // The color to use when painting the line.
                                height: 0.001, // The divider's height extent.
                              ),
                              Text(
                                "Total Items",
                                style: TextStyle(
                                    height: 1.7,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Mulish"),
                              ),
                              const Divider(
                                thickness: 2.2, // thickness of the line
                                indent:
                                    0, // empty space to the leading edge of divider.
                                endIndent:
                                    0, // empty space to the trailing edge of the divider.
                                color: Color.fromARGB(255, 186, 186,
                                    189), // The color to use when painting the line.
                                height: 15, // The divider's height extent.
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                heightFactor: 0.97,
                                child: Container(
                                  height: 248,
                                  alignment: Alignment.bottomCenter,
                                  margin:
                                      const EdgeInsets.only(top: 0, bottom: 0),
                                  child: Center(
                                    child: ListView.builder(
                                        itemCount: samplePosts.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
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
                                          prices = samplePosts[index].totalAmt;

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
                                                          children: <Widget>[
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              heightFactor:
                                                                  0.96,
                                                              child: ListTile(
                                                                leading: Container(
                                                                    margin: const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                    child: CircleAvatar(
                                                                        radius:
                                                                            15,
                                                                        child: Text(
                                                                            '${index + 1}'))),
                                                                title: Column(
                                                                  children: [
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      widthFactor:
                                                                          5.8,
                                                                      heightFactor:
                                                                          0.001,
                                                                      child:
                                                                          Text(
                                                                        "Name: $productName",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            height:
                                                                                1.95,
                                                                            fontFamily:
                                                                                "SignikaNegative-Bold",
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                24,
                                                                                23,
                                                                                23),
                                                                            fontSize:
                                                                                13),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      widthFactor:
                                                                          5.27,
                                                                      heightFactor:
                                                                          0.58,
                                                                      child:
                                                                          Text(
                                                                        gradeName,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            height:
                                                                                4.2,
                                                                            fontFamily:
                                                                                "SignikaNegative-Bold",
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                24,
                                                                                23,
                                                                                23),
                                                                            fontSize:
                                                                                13),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomLeft,
                                                                      widthFactor:
                                                                          7.29,
                                                                      child:
                                                                          Text(
                                                                        "Thickness: $thicknessName   Size: $sizeName",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            height:
                                                                                3.4,
                                                                            fontFamily:
                                                                                "SignikaNegative-Bold",
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                41,
                                                                                41,
                                                                                41),
                                                                            fontSize:
                                                                                13),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .bottomLeft,
                                                                      widthFactor:
                                                                          7.29,
                                                                      child:
                                                                          Text(
                                                                        "Unit: ${samplePosts[index].unit.toString()}   Quantity: ${samplePosts[index].quantity.toString()}",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            height:
                                                                                1.2,
                                                                            fontFamily:
                                                                                "SignikaNegative-Bold",
                                                                            fontWeight: FontWeight
                                                                                .w500,
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                41,
                                                                                41,
                                                                                41),
                                                                            fontSize:
                                                                                13),
                                                                      ),
                                                                    ),
                                                                    Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .topLeft,
                                                                      widthFactor:
                                                                          5.92,
                                                                      child:
                                                                          Text(
                                                                        "Price: Rs.${samplePosts[index].totalAmt.toStringAsFixed(2)}",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            height:
                                                                                1.95,
                                                                            fontFamily:
                                                                                "SignikaNegative-Bold",
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color: Color(0xFF000000),
                                                                            fontSize: 13),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            const Divider(
                                                              thickness:
                                                                  2.2, // thickness of the line
                                                              indent:
                                                                  0, // empty space to the leading edge of divider.
                                                              endIndent:
                                                                  0, // empty space to the trailing edge of the divider.
                                                              color: Color.fromARGB(
                                                                  255,
                                                                  186,
                                                                  186,
                                                                  189), // The color to use when painting the line.
                                                              height:
                                                                  5, // The divider's height extent.
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                              }
                                            }
                                          }
                                          return Container();
                                        }),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2.2, // thickness of the line
                                indent:
                                    0, // empty space to the leading edge of divider.
                                endIndent:
                                    0, // empty space to the trailing edge of the divider.
                                color: Color.fromARGB(255, 186, 186,
                                    189), // The color to use when painting the line.
                                height: 0.001, // The divider's height extent.
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                widthFactor: 5,
                                heightFactor: 0.55,
                                child: Text(
                                  "Subtotal:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 4.13,
                                      fontFamily: "SignikaNegative-Bold",
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF71828a),
                                      fontSize: 13.5),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                heightFactor: 0.0001,
                                child: Container(
                                  height: 17,
                                  width: 195,
                                  margin: const EdgeInsets.only(
                                      right: 14, bottom: 9.5),
                                  child: Text(
                                    "Rs: ${widget.ring[widget.index].totalAmt!}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontFamily: "SignikaNegative-Bold",
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                widthFactor: 3.57,
                                heightFactor: 0.55,
                                child: Text(
                                  "Delivery Fee:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 4.13,
                                      fontFamily: "SignikaNegative-Bold",
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF71828a),
                                      fontSize: 13.5),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                heightFactor: 0.0001,
                                child: Container(
                                  height: 17,
                                  width: 160,
                                  margin: const EdgeInsets.only(
                                      right: 14, bottom: 8),
                                  child: Text(
                                    "Rs: ${widget.ring[widget.index].deliveryCharge!}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontFamily: "SignikaNegative-Bold",
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                widthFactor: 2.24,
                                heightFactor: 0.55,
                                child: Text(
                                  "Discounted Amount:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 4.13,
                                      fontFamily: "SignikaNegative-Bold",
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF71828a),
                                      fontSize: 13.5),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                heightFactor: 0.0001,
                                child: Container(
                                  height: 17,
                                  width: 160,
                                  margin: const EdgeInsets.only(
                                      right: 14, bottom: 8),
                                  child: Text(
                                    "Rs: ${widget.ring[widget.index].discountAmt!.toInt()}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontFamily: "SignikaNegative-Bold",
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2.2, // thickness of the line
                                indent:
                                    0, // empty space to the leading edge of divider.
                                endIndent:
                                    0, // empty space to the trailing edge of the divider.
                                color: Color.fromARGB(255, 186, 186,
                                    189), // The color to use when painting the line.
                                height: 0.001, // The divider's height extent.
                              ),
                              const Align(
                                alignment: Alignment.bottomLeft,
                                widthFactor: 3.9,
                                heightFactor: 0.52,
                                child: Text(
                                  "Order Total:",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 4.13,
                                      fontFamily: "SignikaNegative-Bold",
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 13.5),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                heightFactor: 0.0001,
                                child: Container(
                                  height: 17,
                                  width: 160,
                                  margin: const EdgeInsets.only(
                                      right: 14, bottom: 7.85),
                                  child: Text(
                                    "Rs: ${(widget.ring[widget.index].discountAmt!.toInt() + int.parse(widget.ring[widget.index].totalAmt!)) - (widget.ring[widget.index].deliveryCharge!.toInt())}",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        height: 1.17,
                                        fontFamily: "SignikaNegative-Bold",
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  height: 34.4,
                  width: 90,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFFFFFFF),

                      shape: RoundedRectangleBorder(
                          //to set border radius to button
                          borderRadius: BorderRadius.circular(
                              10)), //background color of button
                    ),
                    child: const Text(
                      "Invoice",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          height: 1.2,
                          fontFamily: "Roboto-Regular",
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 255, 76),
                          fontSize: 16),
                    ),
                    onPressed: () async {
                      final uint8List = await screenshotController.capture();
                      String tempPath = (await getTemporaryDirectory()).path;
                      String fileName = "myFile";
                      if (await Permission.storage.request().isGranted) {
                        File file =
                            await File('$tempPath/$fileName.png').create();
                        file.writeAsBytesSync(uint8List!.toList());
                        await Share.shareFiles([file.path]);
                      }
                    },
                  ),
                ),
              ]),
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
