// ignore_for_file: unnecessary_new

import 'package:ecommerce/dealer.dart';
import 'package:ecommerce/models/cookies.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';
import 'main.dart';
import 'models/cartmodel.dart';
import 'models/profile.dart';
import 'update.dart';
import 'models/profiling.dart';
import 'package:ecommerce/services/api_services.dart';
import 'package:ecommerce/NetworkHandler.dart';
import 'models/ply.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EighthRoute extends StatefulWidget {
  const EighthRoute({Key? key}) : super(key: key);

  @override
  State<EighthRoute> createState() => _EighthRouteState();
}

class _EighthRouteState extends State<EighthRoute> {
  var size, height, width;
  final baseurl = "https://trulam.prabidhienterprises.com/api/";
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
  var prices;
  int total = 0;
  var gradeName, productName, thicknessName, sizeName;
  FlutterSecureStorage storage = FlutterSecureStorage();
  List<Cookies> samplePosts = [];
  var userData = <Cookies>[];
  CartModel cartModel = CartModel();

  NetworkHandler networkHandler = NetworkHandler();
  Post profileModel = Post();

  var isLoading = true;
  @override
  void initState() {
    super.initState();
    dating();
    fetchData();
    data();
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

  Future<List<Cookies>> data() async {
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

  Future deleteById(int id) async {
    String? token = await storage.read(key: "token");
    try {
      final response = await http.get(Uri.parse('${baseurl}cart/destroy/$id'),
          headers: {"Authorization": "Bearer $token"});

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("hello");
        final filtered = userData.where((element) => element.id != id).toList();
        setState(() {
          userData = filtered;
          Provider.of<CartModel>(context, listen: false).updateCartCount(
            Provider.of<CartModel>(context, listen: false).cartCount! - 1,
          );
        });
      } else {
        // handle the error here
        print("Error in deleting the data");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
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
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.57,
        backgroundColor: Color(0xFFFFFFFF),
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
                      color: Color(0xFF6BA444),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                    style: TextStyle(
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
              endIndent: 0, // empty space to the trailing edge of the divider.
              color:
                  Color(0xFF6BA444), // The color to use when painting the line.
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
              endIndent: 0, // empty space to the trailing edge of the divider.
              color:
                  Color(0xFF6BA444), // The color to use when painting the line.
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
              endIndent: 0, // empty space to the trailing edge of the divider.
              color:
                  Color(0xFF6BA444), // The color to use when painting the line.
              height: 0.001, // The divider's height extent.
            ),
          ],
        ),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Color(0xFF6BA444),
              )
            : userData.isEmpty // check if ring list is empty
                ? Text(
                    'Your Cart is Empty',
                    style: TextStyle(
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222222),
                        fontSize: width * 0.08),
                  )
                : Container(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 62),
                      child: ListView.builder(
                        itemCount: userData.length,
                        itemBuilder: (BuildContext context, int index) {
                          final id = userData[index].id;
                          var gradeid = userData[index].gradeId;
                          gradeName = gradelist
                              .firstWhere((grade) => grade.id == gradeid)
                              .title;
                          var productid = userData[index].productId;
                          productName = productlist
                              .firstWhere((product) => product.id == productid)
                              .title;
                          var thicknessid = userData[index].thicknessId;
                          thicknessName = thicknesslist
                              .firstWhere(
                                  (thickness) => thickness.id == thicknessid)
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
                                      style:
                                          TextStyle(color: Color(0xFFFFFFFF)),
                                    )),
                                trailing: isLoading
                                    ? const CircularProgressIndicator()
                                    : PopupMenuButton(
                                        onSelected: ((value) async {
                                          if (value == 'edit') {
                                            editUser(index);
                                          } else if (value == 'delete') {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            deleteById(id);
                                          }
                                        }),
                                        padding: const EdgeInsets.only(
                                            left: 24, bottom: 150),
                                        itemBuilder: (context) {
                                          return [
                                            const PopupMenuItem(
                                              value: 'edit',
                                              child: Text('Edit'),
                                            ),
                                            const PopupMenuItem(
                                              value: 'delete',
                                              child: Text('Delete'),
                                            ),
                                          ];
                                        },
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
                              UiHelper.verticalSpace(vspace: Spacing.xxsmall),
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
                  ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 250, 247, 247),
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF222222),
        unselectedItemColor: Color(0xFF222222),
        selectedFontSize: 12,
        onTap: (value) {
          if (value == 0) Navigator.pushNamed(context, '/fourth');
          if (value == 1) Navigator.pushNamed(context, '/seventh');

          if (value == 2) Navigator.pushNamed(context, '/eighth');
          if (value == 3) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      backgroundColor: Color(0xFFFCD62D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: Text("Are you sure you want to logout?"),
                      titleTextStyle: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                        fontFamily: "Nunito",
                        fontSize: width * 0.045,
                      ),
                      actions: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(left: 55, bottom: 11),
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFFFFF),
                                ),
                                child: Text("Yes",
                                    style: TextStyle(
                                      color: Color(0xFFFCD62D),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Cabin",
                                      fontSize: width * 0.045,
                                    )),
                                onPressed: () {
                                  // Perform logout here
                                  Navigator.pushNamed(context, '/third');
                                },
                              ),
                              UiHelper.horizontaSpace(hspace: Spacing.xxlarge),
                              UiHelper.horizontaSpace(hspace: Spacing.xlarge),
                              UiHelper.horizontaSpace(hspace: Spacing.large),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFFFFFF),
                                ),
                                child: Text("No",
                                    style: TextStyle(
                                      color: Color(0xFFFCD62D),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Cabin",
                                      fontSize: width * 0.045,
                                    )),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        )
                      ]);
                });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Orders",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout_outlined),
            label: "Logout",
          ),
        ],
      ),

      // position the cart button in the center of the bottom navigation bar

      floatingActionButton: Container(
        width: width / 1,
        height: height / 13.8,
        margin: const EdgeInsets.only(left: 0, bottom: 55),
        color: Color(0xFF6BA444),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: [
                  UiHelper.verticalSpace(vspace: Spacing.xxsmall),
                  Container(
                    height: height / 34,
                    width: width / 1.56,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Total Price: Rs:${calculateTotalPrice(userData)}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "SignikaNegative-Bold",
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFFFFFFF),
                          fontSize: width * 0.038,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  UiHelper.verticalSpace(vspace: Spacing.xsmall),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Buy Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: height / 660,
                        fontFamily: "Roboto-Regular",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6BA444),
                        fontSize: width * 0.038,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/tweleventh');
                    },
                  ),
                ],
              ),
            ],
          ),
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  editUser(index) {
    var userId = userData[index].userId.toString();
    var id = userData[index].id.toString();
    var product = productName.toString();
    var grade = gradeName.toString();
    var price = userData[index].totalAmt.toStringAsFixed(2);
    var thickness = thicknessName.toString();
    var size = sizeName.toString();
    var quantity = userData[index].quantity.toString();
    var unit = userData[index].unit.toString();

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NinethScreen(
                userId: userId,
                id: id,
                productName: product,
                gradeName: grade,
                priceName: price,
                thicknessName: thickness,
                size: size,
                unit: unit,
                quantity: quantity)));
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
