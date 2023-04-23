// ignore_for_file: unnecessary_new

import 'dart:convert';

import 'package:ecommerce/services/dpi.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'cart_provider.dart';
import 'models/invoicemodel.dart';
import 'models/ordermodel.dart';
import 'models/profile.dart';
import 'package:http/http.dart' as http;

import 'orderdetails.dart';

class SeventhScreen extends StatefulWidget {
  const SeventhScreen({Key? key}) : super(key: key);

  @override
  State<SeventhScreen> createState() => _SeventhScreenState();
}

class _SeventhScreenState extends State<SeventhScreen> {
  var size, height, width;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    hun();
  }

  List<Datum> ring = [];
  var jin = <Datum>[];
  int _cartCount = 0;

  var isLoading = true;

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
      ring.sort((a, b) => a.id.compareTo(b.id));
    });

    if (response.statusCode == 200) {
      for (var index in data["data"]) {
        ring.insert(0, Datum.fromJson(index));
      }

      return ring;
    } else {
      return ring;
    }
  }

  Future hunging(int idi) async {
    String? token = await storage.read(key: "token");
    try {
      final response = await http.delete(
        Uri.parse(
          'https://trulam.prabidhienterprises.com/api/order/$idi/destroy',
        ),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("hello");
        final filtered = ring.where((element) => element.id != idi).toList();
        setState(() {
          ring = filtered;
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
        title: const Text('Orders',
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(
                color: Color(0xFF6BA444),
              )
            : ring.isEmpty // check if ring list is empty
                ? Text(
                    'No Orders',
                    style: TextStyle(
                        fontFamily: "Mulish",
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF222222),
                        fontSize: width * 0.08),
                  )
                : ListView.builder(
                    itemCount: ring.length,
                    itemBuilder: (BuildContext context, int index) {
                      var idi = ring[index].id;
                      final id = ring[index].orderId;
                      var date = ring[index].createdAt;

                      var delivery = ring[index].deliveryStatus;

                      return Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            heightFactor: 0.96,
                            child: ListTile(
                              leading: CircleAvatar(
                                  backgroundColor: Color(0xFF6BA444),
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(color: Color(0xFFFFFFFF)),
                                  )),
                              title: Column(
                                children: [
                                  Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Order ID: $id",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            height: height *
                                                0.0025, //half of the height size

                                            fontFamily: "SignikaNegative-Bold",
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromARGB(255, 24, 23, 23),
                                            fontSize: //half of the height size
                                                width * 0.04,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 72),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              child: Icon(
                                                Icons.remove_red_eye_rounded,
                                                color: Color(0xFFFCD62D),
                                                size: width * 0.06,
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SixthRoute(
                                                              index: index,
                                                              ring: ring,
                                                            )));
                                              },
                                            ),
                                            UiHelper.horizontaSpace(
                                                hspace: Spacing.large),
                                            GestureDetector(
                                              child: Icon(
                                                Icons.delete_rounded,
                                                size: width * 0.06,
                                                color: Color(0xFF6BA444),
                                              ),
                                              onTap: () {
                                                hunging(idi);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Placed on: ${DateFormat('yyyy-MM-dd hh:mm:ss').format(date!.toLocal())}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        height: height * 0.002,
                                        fontFamily: "SignikaNegative-Bold",
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 41, 41, 41),
                                        fontSize: width * 0.04,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            "Status:",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              height: height * 0.0022,
                                              fontFamily:
                                                  "SignikaNegative-Bold",
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 41, 41, 41),
                                              fontSize: width * 0.04,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: width / 4.75,
                                          height: height / 23,
                                          alignment: Alignment.bottomLeft,
                                          margin: const EdgeInsets.only(
                                              left: 5, top: 5),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF38d354),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              delivery!,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                height: height * 0.0013,
                                                fontFamily:
                                                    "SignikaNegative-Bold",
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFFFFFFFF),
                                                fontSize: width * 0.038,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
                            height: 5, // The divider's height extent.
                          ),
                        ],
                      );
                    },
                  ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 250, 247, 247),
        iconSize: 28,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF6BA444),
        unselectedItemColor: Color(0xFF222222),
        selectedFontSize: 12,
        onTap: (value) {
          if (value == 0) Navigator.pushNamed(context, '/fourth');
          if (value == 1) Navigator.pushNamed(context, '/seventh');
          if (value == 2) Navigator.pushNamed(context, '/eleventh');
          if (value == 3) Navigator.pushNamed(context, '/eighth');
          if (value == 4) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      backgroundColor: Color(0xFF6BA444),
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
                                      color: Color(0xFF6BA444),
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
                                      color: Color(0xFF6BA444),
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
              icon: Container(
                margin: const EdgeInsets.only(top: 18),
              ), // empty container to align cart button in the center
              label: ""),
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/eleventh');
          },
          child: Stack(
            children: <Widget>[
              Icon(
                Icons.shopping_cart,
                size: 25,
              ),
            ],
          ),
          backgroundColor: Color(0xFF6BA444), // set the background color
        ),
      ),
      // position the cart button in the center of the bottom navigation bar
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
