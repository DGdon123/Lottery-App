// ignore_for_file: unnecessary_new

import 'package:ecommerce/dealer.dart';
import 'package:ecommerce/models/cookies.dart';
import 'package:ecommerce/services/bpi.dart';
import 'package:ecommerce/services/help.dart';
import 'package:ecommerce/services/network.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'models/accounting.dart';
import 'models/cartmodel.dart';
import 'models/profile.dart';
import 'update.dart';
import 'models/profiling.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:ecommerce/NetworkHandler.dart';
import 'models/ply.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/ordermodel.dart';

class NinethRoute extends StatefulWidget {
  const NinethRoute({Key? key}) : super(key: key);

  @override
  State<NinethRoute> createState() => _NinethRouteState();
}

class _NinethRouteState extends State<NinethRoute> {
  final baseurl = "https://trulam.prabidhienterprises.com/api/";
  List<Cart> quantity = [];
  Network network = Network();
  Help help = Help();
  List<Grade> gradelist = [];
  List<Product> templist = [];
  List<Product> productlist = [];
  List<Thickness> thicklist = [];
  List<Thickness> thicknesslist = [];
  List<Price> pricelist = [];
  List<Price> pricinglist = [];
  List<Size> sizelist = [];
  List<Size> sizinglist = [];
  List<Datum> ring = [];
  var jin = <Datum>[];
  String? grade;
  String? product;
  String? thickness;
  String? price;
  String? size;
  String? unit;
  Account hell = Account(
      creditBalance: '', discount: '0', deliveryCharge: 0, companyName: '');
  String? data;
  var prices;
  var userId = TextEditingController();
  var emailcon = TextEditingController();
  var add = TextEditingController();
  var call = TextEditingController();
  var address = TextEditingController();
  var calling = TextEditingController();
  var remarks = TextEditingController();
  int total = 0;
  var gradeName, productName, thicknessName, sizeName;
  FlutterSecureStorage storage = FlutterSecureStorage();
  List<Cookies> samplePosts = [];
  var userData = <Cookies>[];
  var sizings, height, width;

  NetworkHandler networkHandler = NetworkHandler();

  Post profileModel = Post();
  var hello = <Cookies>[];

  var isLoading = true;
  @override
  void initState() {
    super.initState();
    //datass();
    //dates();
    dating();
    fetchData();
    datass();
    dataaas();
    hun();
    disprice();

    setState(() {
      add.text = profileModel.address ?? ' ';
      call.text = profileModel.phone ?? ' ';
    });
    //dataaas();
  }

  /* dataaas() async {
    Datum dum = await dates();
    setState(() {
      datalist = dum.data;
    });
  }*/

  Future<List<Cookies>> datass() async {
    var resp = await networkHandler.get("user");
    print(resp);
    profileModel = Post.fromJson(resp);
    print(profileModel);
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

  /*dates() async {
    var response = await network.get("order/7");

    /*Datum? dum = datumFromJson(response);
    print(dum);
    if (dum != null)
      return dum;
    else {
      throw Exception('Failed to load data');
    }
  }*/
  }*/

  Future<List<Datum>> hun() async {
    var resp = await networkHandler.get("user");
    print(resp);
    profileModel = Post.fromJson(resp);
    print(profileModel);
    String? token = await storage.read(key: "token");
    final response = await http.get(
      Uri.parse(
        'https://trulam.prabidhienterprises.com/api/order/${profileModel.id}',
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
        ring.add(Datum.fromJson(index));
      }

      jin = [ring.last];
      return jin;
    } else {
      return ring;
    }
  }

  Future deleteById(int id) async {
    String? token = await storage.read(key: "token");
    try {
      final response = await http.get(Uri.parse('${baseurl}cart//$id'),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("hello");
        final filtered = userData.where((element) => element.id != id).toList();
        setState(() {
          userData = filtered;
        });
      } else {
        // handle the error here
        print("Error in deleting the data");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateUser() async {
    var response = await networkHandler.get("user");
    print(response);
    profileModel = Post.fromJson(response);
    print(profileModel);

    print(hello);
    var demon = {
      "user_id": profileModel.id,
      "address": address.text.trim(),
      "phone_number": calling.text.trim(),
      "extra_info": remarks.text.trim(),
      "items": id(userData),
    };
    print(demon);
    var res = await Api().postData(demon, 'order/${profileModel.id}/store');
    var body = json.decode(res.body);
    print(body);

    if (body['success']) {
      showDialogBox(true);
    } else {
      showDialogBox(false);
    }
  }

  void showDialogBox(bool isSuccessful) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: isSuccessful ? Text("Success") : Text("Unsuccessful"),
            content: isSuccessful
                ? SizedBox(
                    height: 95,
                    child: Column(
                      children: <Widget>[
                        Text("Your Order has been successfully placed!"),
                        Container(
                          margin: const EdgeInsets.only(left: 15, top: 7),
                          child: Row(
                            children: [
                              ElevatedButton(
                                child: Text("Go to Orders"),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/seventh');
                                },
                              ),
                              UiHelper.horizontaSpace(hspace: Spacing.xxlarge),
                              UiHelper.horizontaSpace(hspace: Spacing.large),
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
                  )
                : SizedBox(
                    height: 95,
                    child: Column(
                      children: <Widget>[
                        Text(
                            "You reached your credit limit, Please clear your previous due."),
                        Container(
                          margin: const EdgeInsets.only(left: 30, top: 7),
                          child: Row(
                            children: [
                              ElevatedButton(
                                child: Text("Go to Cart"),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/eleventh');
                                },
                              ),
                              UiHelper.horizontaSpace(hspace: Spacing.xxlarge),
                              UiHelper.horizontaSpace(hspace: Spacing.large),
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

  dataaas() async {
    var res = await network.get("user");
    print(res);
    profileModel = Post.fromJson(res);
    print(profileModel);
    var response = await network.get("user/${profileModel.id}/account");
    print(response);

    setState(() {
      hell = Account.fromJson(response);
      print(hell);

      isLoading = false;
    });
  }

  Future<int> disprice() async {
    var res = await network.get("user");
    profileModel = Post.fromJson(res);
    var response = await network.get("user/${profileModel.id}/account");
    hell = Account.fromJson(response);

    return hell.deliveryCharge;
  }

  @override
  Widget build(BuildContext context) {
    sizings = MediaQuery.of(context).size;
    height = sizings.height;
    width = sizings.width;
    emailcon.text = profileModel.email ?? ' ';
    add.text = profileModel.address ?? ' ';
    call.text = profileModel.phone ?? ' ';

    double hy;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6BA444),
        centerTitle: true,
        title: const Text('CheckOut',
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
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Color(0xFF6BA444),
              )
            : Container(
                child: Column(
                  children: [
                    UiHelper.verticalSpace(vspace: Spacing.small),
                    Container(
                      width: UiHelper.displayWidth(context) * 0.91,
                      child: Text(
                        "Deliver to: ${profileModel.name ?? ' '}",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Mulish"),
                      ),
                    ),
                    UiHelper.verticalSpace(vspace: Spacing.medium),
                    Container(
                      height: UiHelper.displayHeight(context) * 0.27,
                      width: UiHelper.displayWidth(context) * 0.92,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: Offset(0, 8),
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                          //BoxShadow
                        ],
                      ),
                      child: Column(
                        children: [
                          UiHelper.verticalSpace(vspace: Spacing.medium),
                          Row(
                            children: [
                              UiHelper.horizontaSpace(hspace: Spacing.large),
                              UiHelper.horizontaSpace(hspace: Spacing.xsmall),
                              Text(
                                "Address",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mulish",
                                    height: UiHelper.displayHeight(context) *
                                        0.0015,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF222222),
                                    fontSize: width * 0.042),
                              ),
                              UiHelper.horizontaSpace(hspace: Spacing.xxlarge),
                              UiHelper.horizontaSpace(hspace: Spacing.xxlarge),
                              UiHelper.horizontaSpace(hspace: Spacing.xxlarge),
                              UiHelper.horizontaSpace(hspace: Spacing.xlarge),
                              Text(
                                "Phone Number",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mulish",
                                    height: UiHelper.displayHeight(context) *
                                        0.0015,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF222222),
                                    fontSize: width * 0.042),
                              ),
                            ],
                          ),
                          UiHelper.verticalSpace(vspace: Spacing.small),
                          Row(
                            children: [
                              UiHelper.horizontaSpace(hspace: Spacing.xlarge),
                              Container(
                                height: height / 18,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color(0xFF222222),
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                child: TextField(
                                  controller: address,
                                  maxLines: 1,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "${hell.address}",
                                    hintStyle: TextStyle(
                                        height: 1.3,
                                        fontFamily: "SignikaNegative-Regular",
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
                              UiHelper.horizontaSpace(hspace: Spacing.large),
                              Container(
                                height: height / 18,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color(0xFF222222),
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                child: TextField(
                                  controller: calling,
                                  maxLines: 1,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: "${profileModel.phone ?? ' '}",
                                    hintStyle: TextStyle(
                                        height: 1.3,
                                        fontFamily: "SignikaNegative-Regular",
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
                          UiHelper.verticalSpace(vspace: Spacing.medium),
                          Row(
                            children: [
                              UiHelper.horizontaSpace(hspace: Spacing.large),
                              UiHelper.horizontaSpace(hspace: Spacing.xxsmall),
                              Text(
                                "Remarks",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Mulish",
                                    height: UiHelper.displayHeight(context) *
                                        0.0015,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF222222),
                                    fontSize: width * 0.042),
                              ),
                            ],
                          ),
                          UiHelper.verticalSpace(vspace: Spacing.small),
                          Row(
                            children: [
                              UiHelper.horizontaSpace(hspace: Spacing.xlarge),
                              Container(
                                height: height / 18,
                                width: width * 0.84,
                                margin: const EdgeInsets.only(top: 0),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color(0xFF222222),
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                child: TextField(
                                  controller: remarks,
                                  maxLines: 1,
                                  cursorColor: Colors.black,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    hintText: "Enter your message",
                                    hintStyle: TextStyle(
                                        height: 2,
                                        fontFamily: "SignikaNegative-Regular",
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
                    ),
                    UiHelper.verticalSpace(vspace: Spacing.medium),
                    Text(
                      "Total Items",
                      style: TextStyle(
                          fontSize: width * 0.052,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Mulish"),
                    ),
                    UiHelper.verticalSpace(vspace: Spacing.medium),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Container(
                            height: UiHelper.displayHeight(context) * 0.174,
                            child: ListView.builder(
                              itemCount: userData.length,
                              itemBuilder: (BuildContext context, int index) {
                                final id = userData[index].userId;
                                var gradeid = userData[index].gradeId;
                                gradeName = gradelist
                                    .firstWhere((grade) => grade.id == gradeid)
                                    .title;
                                var productid = userData[index].productId;
                                productName = productlist
                                    .firstWhere(
                                        (product) => product.id == productid)
                                    .title;
                                var thicknessid = userData[index].thicknessId;
                                thicknessName = thicknesslist
                                    .firstWhere((thickness) =>
                                        thickness.id == thicknessid)
                                    .title;
                                var priceid = userData[index].totalAmt;
                                var sizeid = userData[index].sizeId;
                                sizeName = sizinglist
                                    .firstWhere((size) => size.id == sizeid)
                                    .title;
                                prices = userData[index].totalAmt;

                                return Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Color(0xFF6BA444),
                                        child: Text(
                                          '${index + 1}',
                                          style: TextStyle(
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                      ),
                                      title: Column(
                                        children: [
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.xsmall),
                                          Row(
                                            children: [
                                              Text(
                                                "Name: $productName",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "SignikaNegative-Bold",
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 24, 23, 23),
                                                    fontSize: width * 0.042),
                                              ),
                                            ],
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.small),
                                          Row(
                                            children: [
                                              Text(
                                                gradeName,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "SignikaNegative-Bold",
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 24, 23, 23),
                                                    fontSize: width * 0.040),
                                              ),
                                            ],
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.small),
                                          Row(
                                            children: [
                                              Text(
                                                "Thickness: $thicknessName   Size: $sizeName",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "SignikaNegative-Bold",
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 41, 41, 41),
                                                    fontSize: width * 0.036),
                                              ),
                                            ],
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.small),
                                          Row(
                                            children: [
                                              Text(
                                                "Unit: ${userData[index].unit.toString()}   Quantity: ${userData[index].quantity.toString()}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "SignikaNegative-Bold",
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 41, 41, 41),
                                                    fontSize: width * 0.036),
                                              ),
                                            ],
                                          ),
                                          UiHelper.verticalSpace(
                                              vspace: Spacing.small),
                                          Row(
                                            children: [
                                              Text(
                                                "Price: Rs.${userData[index].totalAmt.toStringAsFixed(2)}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily:
                                                        "SignikaNegative-Bold",
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF000000),
                                                    fontSize: width * 0.036),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    UiHelper.verticalSpace(
                                        vspace: Spacing.xxsmall),
                                    const Divider(
                                      thickness: 2.2, // thickness of the line
                                      indent:
                                          0, // empty space to the leading edge of divider.
                                      endIndent:
                                          0, // empty space to the trailing edge of the divider.
                                      color: Color.fromARGB(255, 186, 186,
                                          189), // The color to use when painting the line.
                                      // The divider's height extent.
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
      ),
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: Container(
          height: UiHelper.displayHeight(context) * 0.25,
          width: UiHelper.displayWidth(context) * 1,
          color: Color(0xFF6BA444),
          child: Row(
            children: <Widget>[
              Column(
                children: [
                  UiHelper.verticalSpace(vspace: Spacing.xsmall),
                  Row(
                    children: [
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Subtotal Price:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        margin: const EdgeInsets.only(left: 14),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rs:${calculateTotalPrice(userData)}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Discounted Price:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                      UiHelper.horizontaSpace(hspace: Spacing.xlarge),
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        margin: const EdgeInsets.only(left: 7.6),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rs:${(hy = (calculateTotalPrice(userData) * (int.parse(hell.discount) / 100)).toDouble()).toInt()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Delivery Fee:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                      UiHelper.horizontaSpace(hspace: Spacing.xlarge),
                      UiHelper.horizontaSpace(hspace: Spacing.small),
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        margin: const EdgeInsets.only(left: 14.9),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rs:${hell.deliveryCharge}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UiHelper.verticalSpace(vspace: Spacing.xsmall),
                  Container(
                    height: UiHelper.displayHeight(context) * 0.003,
                    width: UiHelper.displayWidth(context) * 1,
                    alignment: Alignment.bottomLeft,
                    color: Color(0xFFFFFFFF),
                  ),
                  Row(
                    children: [
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Total Price:",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                      UiHelper.horizontaSpace(hspace: Spacing.xlarge),
                      UiHelper.horizontaSpace(hspace: Spacing.small),
                      Container(
                        height: UiHelper.displayHeight(context) * 0.035,
                        margin: const EdgeInsets.only(left: 24.5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rs:${(calculateTotalPrice(userData).toInt() + (hy.toInt())) - hell.deliveryCharge.toInt()}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "SignikaNegative-Bold",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFFFFFF),
                              fontSize: UiHelper.displayWidth(context) * 0.038,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  UiHelper.verticalSpace(vspace: Spacing.small),
                  Container(
                    height: height * 0.065,
                    width: width * 0.88,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFFFFFFF),

                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(3)),
                        //background color of button
                      ),
                      child: Text(
                        "Place Order",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.2,
                          fontFamily: "Roboto-Regular",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6BA444),
                          fontSize: width * 0.055,
                        ),
                      ),
                      onPressed: () {
                        updateUser();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

double calculateTotalPrice(List<Cookies> userData) {
  double total = 0;
  for (var item in userData) {
    double price = item.totalAmt;
    total += price;
  }
  return double.parse(total.toStringAsFixed(2));
}

List<int> id(List<Cookies> userData) {
  List<int> idList = [];
  for (var item in userData) {
    int? price = item.id;
    if (price != null) {
      idList.add(price);
    }
  }
  return idList;
}

double rolex(List<Datum> jin) {
  double total = 0;
  for (var item in jin) {
    String? price = item.deliveryCharge as String?;
    total += price! as double;
  }
  return double.parse(total.toStringAsFixed(2));
}

double grand(List<Datum> jin) {
  double grand = 0;
  for (var item in jin) {
    int price = item.deliveryCharge as int;
    double? subtotal = item.totalAmt as double?;
    double? discount = item.discountAmt;
    grand = (subtotal! + price) - discount!;
  }
  return double.parse(grand.toStringAsFixed(2));
}



/*String addresss(List<DatumElement> datalist) {
  var address;
  for (var item in datalist) {
    var add = item.address;
    address = add.toString();
  }

  return address;
}*/

  

