// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce/NetworkHandler.dart';
import 'package:badges/badges.dart' as badges;

import 'package:ecommerce/services/bpi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ecommerce/models/cartmodel.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'models/cookies.dart';
import 'models/ply.dart';
import 'models/profiling.dart';
import 'ui_helper.dart';

class NinethScreen extends StatefulWidget {
  const NinethScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NinethScreen> createState() => _NinethScreenState();
}

class _NinethScreenState extends State<NinethScreen> {
  dynamic argumentData = Get.arguments;
  var sizings, height, width;
  final baseurl = "https://trulam.prabidhienterprises.com/api/";
  final storage = const FlutterSecureStorage();
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
  var userId = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  Posting profileModel = Posting();
  var isLoading = true;
  List<Cookies> samplePosts = [];
  var userData = <Cookies>[];
  String id = '';
  Color originalButtonColor = const Color(0xFF6BA444);
  Color? _buttonColor;
  bool _clicked = false;

  @override
  void initState() {
    super.initState();
    dating();
    _buttonColor = originalButtonColor;
    fetchData();
    data();
  }

  void showDialogBox(bool isSuccessful) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color(0xFFFCD62D),
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
                                      color: const Color(0xFFFCD62D),
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
                                      color: const Color(0xFFFCD62D),
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

  Future<List<Cookies>> data() async {
    String? token = await storage.read(key: "token");
    final response = await http.get(
      Uri.parse(
        'https://trulam.prabidhienterprises.com/api/cart/',
      ),
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    print(data["data"]);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      for (var index in data["data"]) {
        samplePosts.add(Cookies.fromJson(index));
      }

      var userId = profileModel.id;

      userData = samplePosts.where((item) => item.userId == userId).toList();

      return userData;
    } else {
      return samplePosts;
    }
  }

  void dating() async {
    var response = await networkHandler.get("user");
    print(response);
    setState(() {
      profileModel = Posting.fromJson(response);
      print(profileModel);
    });
  }

  updateUser() async {
    var data = {
      "id": id,
      "user_id": profileModel.id,
      "grade_id": grading.text.trim(),
      "product_id": products.text.trim(),
      "thickness_id": thicknessing.text.trim(),
      "size_id": sizing.text.trim(),
      "quantity": quantitative.text.trim(),
      "unit": uniting.text.trim()
    };
    print(data);
    var res = await Api().postData(data, 'cart/update/$id');
    var body = json.decode(res.body);
    print(body);

    if (body['success']) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: const Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text("Successfully Updated!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xFF6BA444),
                      fontWeight: FontWeight.w700,
                      fontFamily: "Nunito",
                      fontSize: width * 0.050,
                    )),
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 11,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6BA444),
                          ),
                          child: Text("Go Back",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Cabin",
                                fontSize: width * 0.045,
                              )),
                          onPressed: () {
                            // Perform logout here
                            Navigator.pushNamed(context, '/eleventh');
                          },
                        ),
                        Container(
                          width: UiHelper.displayWidth(context) * 0.11,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6BA444),
                          ),
                          child: Text("Edit",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Cabin",
                                fontSize: width * 0.045,
                              )),
                          onPressed: () {
                            // Perform logout here
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  )
                ]);
          });
    } else {
      final logInErrorBar = SnackBar(
        content: Text(
          "Unsucessful!!!",
          style: TextStyle(
            color: Colors.grey.shade900,
            fontSize: 17,
            fontFamily: 'OpenSans',
          ),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(milliseconds: 3000),
        backgroundColor: Colors.red.shade400,
      );
      ScaffoldMessenger.of(context).showSnackBar(logInErrorBar);
      setState(() {
        _clicked = true;
        _buttonColor = const Color(0xFF6BA444);
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _clicked = false;
        _buttonColor = originalButtonColor;
      });
    }
  }

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

  @override
  void onInit() {
    print(argumentData[0]['address']);
    print(argumentData[1]['email']);
    print(argumentData[2]['mobile']);
    print(argumentData[3]['gift']);
    print(argumentData[4]['name']);
  }

  @override
  Widget build(BuildContext context) {
    sizings = MediaQuery.of(context).size;
    height = sizings.height;
    width = sizings.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6BA444),
        centerTitle: true,
        title: Text('Edit Profile',
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontFamily: 'Nunito',
              fontSize: 19.2.sp,
              height: 0.16.h,
              letterSpacing: 0.4,
              fontWeight: FontWeight.w900,
            )),
        iconTheme: IconThemeData(
          size: 22.sp, //change size on your need
          color: const Color(0xFFFFFFFF), //change color on your need
        ),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Get.back(result: [
                  {"backValue": "one"}
                ]);
              },
            );
          },
        ),
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
                                  height: 2.h,
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
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF222222),
                                        fontSize: 15.5.sp),
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
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: const Color(0xFF6BA444)
                                              .withOpacity(0.2),
                                          hintText: argumentData[4]['name'],
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
                                    "Mobile Number",
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
                                          hintText: argumentData[2]['mobile'],
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
