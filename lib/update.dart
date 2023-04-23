// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ecommerce/NetworkHandler.dart';
import 'package:ecommerce/cart.dart';
import 'package:ecommerce/models/cooking.dart';

import 'package:ecommerce/services/bpi.dart';
import 'package:ecommerce/services/cpi.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ecommerce/models/cartmodel.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import 'services/api.dart';

import 'data_class.dart';
import 'models/cookies.dart';
import 'models/ply.dart';
import 'models/profiling.dart';
import 'ui_helper.dart';

class NinethScreen extends StatefulWidget {
  NinethScreen(
      {required this.userId,
      required this.id,
      required this.productName,
      required this.gradeName,
      required this.priceName,
      required this.thicknessName,
      required this.unit,
      required this.size,
      required this.quantity});
  String userId;
  String id;
  String productName;
  String gradeName;
  String priceName;
  String thicknessName;
  String size;
  String unit;
  String quantity;

  @override
  State<NinethScreen> createState() => _NinethScreenState();
}

class _NinethScreenState extends State<NinethScreen> {
  var sizings, height, width;
  final baseurl = "https://trulam.prabidhienterprises.com/api/";
  final storage = FlutterSecureStorage();
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
  Color originalButtonColor = Color(0xFF6BA444);
  Color? _buttonColor;
  bool _clicked = false;

  @override
  void initState() {
    super.initState();
    dating();
    _buttonColor = originalButtonColor;
    fetchData();
    data();
    print(widget.userId);
    print(widget.id);
    print(widget.productName);
    print(widget.gradeName);
    print(widget.priceName);
    print(widget.thicknessName);
    print(widget.size);
    print(widget.unit);
    print(widget.quantity);
    setState(() {
      id = widget.id;
      userId.text = widget.userId;
      products.text = widget.productName;
      grading.text = widget.gradeName;
      pricing.text = widget.priceName;
      thicknessing.text = widget.thicknessName;
      sizing.text = widget.size;
      uniting.text = widget.unit;
      quantitative.text = widget.quantity;
    });
  }

  void showDialogBox(bool isSuccessful) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Color(0xFFFCD62D),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: isSuccessful
                ? Text(
                    "Success",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w600,
                      fontFamily: "Cabin",
                      fontSize: width * 0.058,
                    ),
                  )
                : Text("Unsuccessful"),
            content: isSuccessful
                ? SizedBox(
                    height: UiHelper.displayHeight(context) * 0.122,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Successfully added to cart!!!",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
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
                                  backgroundColor: Color(0xFFFFFFFF),
                                ),
                                child: Text("Place Again",
                                    style: TextStyle(
                                      color: Color(0xFFFCD62D),
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
                                child: Text("Close",
                                    style: TextStyle(
                                      color: Color(0xFFFCD62D),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Cabin",
                                      fontSize: width * 0.04,
                                    )),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFFFFF),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/eleventh');
                                },
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
                        Text("Please fill up all the fields!!!"),
                        Container(
                          margin: const EdgeInsets.only(left: 35, top: 7),
                          child: Row(
                            children: [
                              ElevatedButton(
                                child: Text("Close"),
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
                backgroundColor: Color(0xFFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                title: Text("Successfully Updated!!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF6BA444),
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
                            backgroundColor: Color(0xFF6BA444),
                          ),
                          child: Text("Go Back",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
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
                            backgroundColor: Color(0xFF6BA444),
                          ),
                          child: Text("Edit",
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
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
        _buttonColor = Color(0xFF6BA444);
      });
      await Future.delayed(Duration(seconds: 1));
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
  Widget build(BuildContext context) {
    sizings = MediaQuery.of(context).size;
    height = sizings.height;
    width = sizings.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6BA444),
        centerTitle: true,
        title: const Text('My Cart',
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
                Navigator.pushNamed(context, '/eleventh');
              },
            );
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Color(0xFF6BA444),
              )
            : Column(
                children: [
                  Container(
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          height: UiHelper.displayHeight(context) * 0.97,
                          child: Column(
                            children: [
                              UiHelper.verticalSpace(vspace: Spacing.xxsmall),
                              Row(
                                children: [
                                  UiHelper.horizontaSpace(
                                      hspace: Spacing.xlarge),
                                  Text(
                                    "Edit Your Cart Items",
                                    style: TextStyle(
                                      fontFamily: "Catamaran",
                                      color: Color(0xFF222222),
                                      fontSize: width * 0.062,
                                      height: height / 350,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.xlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Text(
                                        "Grade",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Mulish",
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.0015,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.042),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Container(
                                        height: height / 18,
                                        width: width * 0.9,
                                        margin: const EdgeInsets.only(top: 0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border: Border.all(
                                              color: const Color(0xFF222222),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: DropdownButton2(
                                          dropdownMaxHeight: 150,
                                          itemPadding:
                                              const EdgeInsets.only(left: 16),
                                          isExpanded: true,
                                          style: const TextStyle(
                                              height: 1.3,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1B1B1E),
                                              fontSize: 14.7),
                                          underline: Container(
                                              color: Colors.transparent),
                                          hint: Text(widget.gradeName),
                                          value: grade,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              product = null;

                                              grade = newvalue.toString();
                                              templist = productlist
                                                  .where((element) =>
                                                      element.gradeId
                                                          .toString() ==
                                                      grade.toString())
                                                  .toList();
                                            });
                                            grading.text = newvalue.toString();
                                          },
                                          items: gradelist.map((itemone) {
                                            return DropdownMenuItem(
                                                value: itemone.id.toString(),
                                                child: Text(itemone.title));
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.xlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Text(
                                        "Product",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Mulish",
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.0015,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.042),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Container(
                                        height: height / 18,
                                        width: width * 0.9,
                                        margin: const EdgeInsets.only(top: 0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border: Border.all(
                                              color: const Color(0xFF222222),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: DropdownButton2(
                                          dropdownMaxHeight: 150,
                                          itemPadding:
                                              const EdgeInsets.only(left: 16),
                                          isExpanded: true,
                                          style: const TextStyle(
                                              height: 1.3,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1B1B1E),
                                              fontSize: 14.7),
                                          underline: Container(
                                              color: Colors.transparent),
                                          hint: Text(widget.productName),
                                          value: product,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              thickness = null;
                                              product = newvalue.toString();
                                              thicklist = thicknesslist
                                                  .where((element) =>
                                                      element.productId
                                                              .toString() ==
                                                          product.toString() &&
                                                      element.gradeId
                                                              .toString() ==
                                                          grade.toString())
                                                  .toList();
                                            });
                                            products.text = newvalue.toString();
                                          },
                                          items: templist.map((itemone) {
                                            return DropdownMenuItem(
                                                value: itemone.id.toString(),
                                                child: Text(itemone.title));
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.xlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Text(
                                        "Thickness",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Mulish",
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.0015,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.042),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Container(
                                        height: height / 18,
                                        width: width * 0.9,
                                        margin: const EdgeInsets.only(top: 0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border: Border.all(
                                              color: const Color(0xFF5C573E),
                                              width: 1.6,
                                              style: BorderStyle.solid),
                                        ),
                                        child: DropdownButton2(
                                          dropdownMaxHeight: 150,
                                          itemPadding:
                                              const EdgeInsets.only(left: 16),
                                          isExpanded: true,
                                          style: const TextStyle(
                                              height: 1.3,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1B1B1E),
                                              fontSize: 14.7),
                                          underline: Container(
                                              color: Colors.transparent),
                                          hint: Text(widget.thicknessName),
                                          value: thickness,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              thickness = newvalue.toString();
                                            });
                                            thicknessing.text =
                                                newvalue.toString();
                                          },
                                          items: thicklist.map((itemone) {
                                            return DropdownMenuItem(
                                                value: itemone.id.toString(),
                                                child: Text(itemone.title));
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.xlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Text(
                                        "Size",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Mulish",
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.0015,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.042),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Container(
                                        height: height / 18,
                                        width: width * 0.9,
                                        margin: const EdgeInsets.only(top: 0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border: Border.all(
                                              color: const Color(0xFF222222),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: DropdownButton2(
                                          dropdownMaxHeight: 150,
                                          itemPadding:
                                              const EdgeInsets.only(left: 16),
                                          isExpanded: true,
                                          style: const TextStyle(
                                              height: 1.3,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1B1B1E),
                                              fontSize: 14.7),
                                          underline: Container(
                                              color: Colors.transparent),
                                          hint: const Text("Select Size"),
                                          value: size,
                                          onChanged: (newvalue) {
                                            setState(() {
                                              size = newvalue.toString();
                                            });
                                            sizing.text = newvalue.toString();
                                          },
                                          items: sizinglist.map((itemone) {
                                            return DropdownMenuItem(
                                                value: itemone.id.toString(),
                                                child: Text(itemone.title));
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.verticalSpace(
                                          vspace: Spacing.xlarge),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Text(
                                        "Unit",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "Mulish",
                                            height: UiHelper.displayHeight(
                                                    context) *
                                                0.0015,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.042),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Container(
                                        height: height / 18,
                                        width: width * 0.9,
                                        margin: const EdgeInsets.only(top: 0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border: Border.all(
                                              color: const Color(0xFF222222),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: DropdownButton2(
                                          dropdownMaxHeight: 150,
                                          itemPadding:
                                              const EdgeInsets.only(left: 16),
                                          isExpanded: true,
                                          style: const TextStyle(
                                              height: 1.3,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1B1B1E),
                                              fontSize: 14.7),
                                          underline: Container(
                                              color: Colors.transparent),
                                          value: uni,
                                          items: units.map((String itemone) {
                                            return DropdownMenuItem(
                                                value: itemone,
                                                child: Text(itemone));
                                          }).toList(),
                                          onChanged: (String? newvalue) {
                                            setState(() {
                                              price = null;
                                              uni = newvalue!;
                                              pricelist = pricinglist
                                                  .where((element) =>
                                                      element.productId
                                                              .toString() ==
                                                          product.toString() &&
                                                      element.gradeId
                                                              .toString() ==
                                                          grade.toString() &&
                                                      element.thicknessId
                                                              .toString() ==
                                                          thickness.toString())
                                                  .toList();
                                            });
                                            uniting.text = newvalue.toString();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 2.2, // thickness of the line
                                    indent:
                                        0, // empty space to the leading edge of divider.
                                    endIndent:
                                        0, // empty space to the trailing edge of the divider.
                                    color: Color.fromARGB(255, 186, 186,
                                        189), // The color to use when painting the line.
                                    height:
                                        30.5, // The divider's height extent.
                                  ),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Text(
                                        "Price:",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: height * 0.00096,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF222222),
                                            fontSize: width * 0.042),
                                      ),
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xsmall),
                                      for (var item in pricelist)
                                        Container(
                                          width: width * 0.64,
                                          height: height * 0.033,
                                          margin:
                                              const EdgeInsets.only(bottom: 0),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                            style: TextStyle(
                                                fontFamily:
                                                    "SignikaNegative-Bold",
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: width * 0.044),
                                            controller: pricing
                                              ..text = uni == "ft"
                                                  ? "Rs. ${item.ftPrice} per/${uni}²"
                                                  : "Rs. ${item.mtrPrice} per/${uni}²",
                                            enabled: false,
                                          ),
                                        ),
                                      for (var item in pricelist)
                                        Container(
                                          width: 1,
                                          height: 20,
                                          margin:
                                              const EdgeInsets.only(left: 5),
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                                border: InputBorder.none),
                                            style: const TextStyle(
                                                height: 0.64,
                                                fontFamily:
                                                    "SignikaNegative-Bold",
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 17.5),
                                            enabled: false,
                                            controller: prices
                                              ..text = "${item.id}",
                                          ),
                                        ),
                                    ],
                                  ),
                                  const Divider(
                                    thickness: 2.2, // thickness of the line
                                    indent:
                                        0, // empty space to the leading edge of divider.
                                    endIndent:
                                        0, // empty space to the trailing edge of the divider.
                                    color: Color.fromARGB(255, 186, 186,
                                        189), // The color to use when painting the line.
                                    height:
                                        24.5, // The divider's height extent.
                                  ),
                                  UiHelper.verticalSpace(
                                      vspace: Spacing.xxsmall),
                                  Row(children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.xlarge),
                                    Text(
                                      "Quantity",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: "Mulish",
                                          height:
                                              UiHelper.displayHeight(context) *
                                                  0.0015,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF222222),
                                          fontSize: width * 0.042),
                                    ),
                                  ]),
                                  UiHelper.verticalSpace(vspace: Spacing.small),
                                  Row(
                                    children: [
                                      UiHelper.horizontaSpace(
                                          hspace: Spacing.xlarge),
                                      Container(
                                        height: height / 18,
                                        width: width * 0.9,
                                        margin: const EdgeInsets.only(top: 0),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          border: Border.all(
                                              color: const Color(0xFF222222),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        child: TextField(
                                          controller: quantitative,
                                          maxLines: 1,
                                          cursorColor: Colors.black,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText:
                                                'Enter quantity of your plywood',
                                            hintStyle: TextStyle(
                                                height: 2,
                                                fontFamily:
                                                    "SignikaNegative-Regular",
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF1B1B1E),
                                                fontSize: 14.7),
                                            contentPadding: EdgeInsets.all(8),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            ),
                                          ),
                                          style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              UiHelper.verticalSpace(vspace: Spacing.large),
                              Container(
                                child: Column(
                                  children: [
                                    Container(
                                      height: height * 0.065,
                                      width: width * 0.88,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(
                                              0xFF6BA444), //background color of button
                                          //border width and color

                                          shape: RoundedRectangleBorder(
                                              //to set border radius to button
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                        ),
                                        child: Text(
                                          "Update",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            height: height * 0.001,
                                            fontFamily: "ZenKakuGothicAntique",
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: width * 0.055,
                                          ),
                                        ),
                                        onPressed: () async {
                                          updateUser();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
