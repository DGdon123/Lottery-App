// ignore_for_file: unnecessary_new

import 'package:ecommerce/services/network.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';

import 'NetworkHandler.dart';
import 'models/profile.dart';

class SixthScreen extends StatefulWidget {
  const SixthScreen({Key? key}) : super(key: key);

  @override
  State<SixthScreen> createState() => _SixthScreenState();
}

NetworkHandler networkHandler = NetworkHandler();
Network network = Network();

Post profileModel = Post();
String creditBalance = "0.00";

class _SixthScreenState extends State<SixthScreen> {
  @override
  void initState() {
    super.initState();

    fetchData();
    //rowing();
  }

  void fetchData() async {
    var response = await networkHandler.get("user");
    print(response);

    setState(() {
      profileModel = Post.fromJson(response);
      print(profileModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 246, 248, 249),
          centerTitle: true,
          title: const Text('SAGUNPLY',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Roboto Bold',
                fontSize: 24,
                fontWeight: FontWeight.w800,
              )),
          iconTheme: const IconThemeData(
            size: 30, //change size on your need
            color: Color.fromARGB(255, 0, 0, 0), //change color on your need
          ),
          elevation: 0,
          actions: [
            Container(
              width: 60,
              height: 20,
              padding: const EdgeInsets.only(top: 11),
              margin: const EdgeInsets.only(right: 11, bottom: 2),
              child: ClipRRect(
                // ignore: sort_child_properties_last
                child: Image.asset(
                  "images/logo.png",
                  width: 200,
                  height: 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
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
                      color: Color(0xFFD71B23),
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
                        color: Color(0xFFD71B23),
                        fontFamily: "Cabin",
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
                onTap: (() {
                  Navigator.pushNamed(context, '/eighth');
                })),
            UiHelper.verticalSpace(vspace: Spacing.medium),
            ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Color(0xFFD71B23),
                  size: 26,
                ),
                title: const Text('Home',
                    style: TextStyle(
                        color: Color(0xFFD71B23),
                        fontFamily: "Cabin",
                        fontSize: 17,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600)),
                onTap: (() {
                  Navigator.pushNamed(context, '/fourth');
                })),
            ListTile(
                leading: const Icon(
                  Icons.inventory,
                  color: Color(0xFFD71B23),
                  size: 26,
                ),
                title: const Text('Orders',
                    style: TextStyle(
                        color: Color(0xFFD71B23),
                        fontFamily: "Cabin",
                        fontSize: 17,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600)),
                onTap: (() {
                  Navigator.pushNamed(context, '/seventh');
                })),
            const Divider(
              thickness: 1.2, // thickness of the line
              indent: 0, // empty space to the leading edge of divider.
              endIndent: 0, // empty space to the trailing edge of the divider.
              color:
                  Color(0xFFD71B23), // The color to use when painting the line.
              height: 0.001, // The divider's height extent.
            ),
            ListTile(
                leading: const Icon(
                  Icons.shopping_cart_rounded,
                  color: Color(0xFFD71B23),
                  size: 26,
                ),
                title: const Text('Cart',
                    style: TextStyle(
                        color: Color(0xFFD71B23),
                        fontFamily: "Cabin",
                        fontSize: 17,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600)),
                onTap: (() {
                  Navigator.pushNamed(context, '/eleventh');
                })),
            ListTile(
                leading: const Icon(
                  Icons.help_outlined,
                  color: Color(0xFFD71B23),
                  size: 26,
                ),
                title: const Text('Help',
                    style: TextStyle(
                        color: Color(0xFFD71B23),
                        fontFamily: "Cabin",
                        fontSize: 17,
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w600)),
                onTap: (() {
                  Navigator.pushNamed(context, '/tenth');
                })),
            const Divider(
              thickness: 1.2, // thickness of the line
              indent: 0, // empty space to the leading edge of divider.
              endIndent: 0, // empty space to the trailing edge of the divider.
              color:
                  Color(0xFFD71B23), // The color to use when painting the line.
              height: 0.001, // The divider's height extent.
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: 500.75,
                width: 500.0,
                child: Container(
                  child: Column(
                    children: [
                      const Align(
                        heightFactor: 1.2,
                        alignment: Alignment.bottomCenter,
                        child: Icon(Icons.check_circle_rounded,
                            size: 84, color: Color(0xFF38d354)),
                      ),
                      const Align(
                          heightFactor: 1.1,
                          alignment: Alignment.center,
                          child: Text(
                            "Your Order has been placed",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF38d354),
                              fontFamily: "Roboto-Black",
                              fontSize: 27,
                            ),
                          )),
                      Align(
                        heightFactor: 1.15,
                        child: Container(
                          height: 185.0,
                          width: 270.0,
                          margin: const EdgeInsets.all(0.1),
                          padding: const EdgeInsets.all(0.1),
                          color: Colors.transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    width: 0.2,
                                    style: BorderStyle.solid),
                              ),
                              child: Column(
                                children: [
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    widthFactor: 6.55,
                                    heightFactor: 0.55,
                                    child: Text(
                                      "No.1",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 4.13,
                                          fontFamily: "SignikaNegative-Bold",
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF7a7a7a),
                                          fontSize: 17.5),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    widthFactor: 0.27,
                                    heightFactor: 0.45,
                                    child: Text(
                                      "by SAGUNPLY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 4.13,
                                          fontFamily: "SignikaNegative-Bold",
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF808080),
                                          fontSize: 12.5),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomRight,
                                    widthFactor: 1.84,
                                    heightFactor: 0.4,
                                    child: Text(
                                      "COMMERCIAL PLY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 4.13,
                                          fontFamily: "SignikaNegative-Bold",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF000000),
                                          fontSize: 15.5),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomLeft,
                                    heightFactor: 0.42,
                                    widthFactor: 2.44,
                                    child: Container(
                                      height: 88.0,
                                      width: 100.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              "images/sixth.jpg",
                                            ),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    widthFactor: 0.33,
                                    heightFactor: 0.0001,
                                    child: Text(
                                      "Rs: 1,000",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 7,
                                          fontFamily: "SignikaNegative-Bold",
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF38d354),
                                          fontSize: 13),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.bottomLeft,
                                    widthFactor: 0.53,
                                    heightFactor: 0.2,
                                    child: Text(
                                      "x 10",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 4.13,
                                          fontFamily: "SignikaNegative-Bold",
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 15.5),
                                    ),
                                  ),
                                  Align(
                                    heightFactor: 1,
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      height: 34.4,
                                      width: 140,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(
                                              0xFF38d354), //background color of button
                                        ),
                                        child: const Text(
                                          "Order Details",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 1.2,
                                              fontFamily: "Roboto-Regular",
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/sixth');
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 246, 248, 249),
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        selectedFontSize: 12,
        onTap: (value) {
          if (value == 0) Navigator.pushNamed(context, '/fourth');
          if (value == 1) Navigator.pushNamed(context, '/seventh');
          if (value == 2) Navigator.pushNamed(context, '/eleventh');
          if (value == 3) Navigator.pushNamed(context, '/eighth');
          if (value == 4) Navigator.pushNamed(context, '/third');
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: "Orders"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Account"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.logout_outlined,
              ),
              label: "Logout")
        ],
      ),
    );
  }
}
