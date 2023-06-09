// ignore_for_file: unnecessary_new

import 'package:ecommerce/services/network.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';

import 'NetworkHandler.dart';
import 'models/profile.dart';

class EighthScreen extends StatefulWidget {
  const EighthScreen({Key? key}) : super(key: key);

  @override
  State<EighthScreen> createState() => _EighthScreenState();
}

NetworkHandler networkHandler = NetworkHandler();
Network network = Network();

Post profileModel = Post();
String creditBalance = "0.00";

class _EighthScreenState extends State<EighthScreen> {
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
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF6BA444),
        centerTitle: true,
        title: const Text('Help',
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
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
            child: Column(
              children: [
                UiHelper.verticalSpace(vspace: Spacing.small),
                const Text(
                  "FAQs",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFFFCD62D),
                    fontSize: 14,
                    fontFamily: "BalooTammudu2",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                UiHelper.verticalSpace(vspace: Spacing.xsmall),
                const Text(
                  "Frequently asked questions",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Color(0xFFFCD62D),
                    fontSize: 25.5,
                    height: 1.44,
                    fontFamily: "BalooTammudu2",
                    fontWeight: FontWeight.w700,
                  ),
                ),
                UiHelper.verticalSpace(vspace: Spacing.medium),
                const Text(
                  "Have questions? We're here to help.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    height: 0.85,
                    color: Color(0xFFFCD62D),
                    fontSize: 16,
                    fontFamily: "Athiti",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Divider(
                  thickness: 1.8, // thickness of the line
                  indent: 0, // empty space to the leading edge of divider.
                  endIndent:
                      0, // empty space to the trailing edge of the divider.
                  color: const Color(0xFF222222).withOpacity(
                      0.7), // The color to use when painting the line.
                  height: 40, // The divider's height extent.
                ),
                Card(
                    margin: const EdgeInsets.only(top: 0, left: 12, right: 12),
                    color: const Color(0xFF6BA444).withOpacity(0.75),
                    child: ExpansionTile(
                      title: const Text(
                        "How does billing work?",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16.8,
                            fontFamily: "Cambay",
                            fontWeight: FontWeight.w600),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: Color(0xFFFFFFFF),
                      ),
                      children: [
                        Container(
                          color: const Color(0xFFFFFFFF),
                          height: UiHelper.displayHeight(context) * 0.45,
                          width: UiHelper.displayWidth(context) * 0.939,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Admin generates a bill for a specific Dealer. The bill \nwill detail the item being purchased, the quantity, and \nthe price. Additionally, the bill will indicate the \ndiscount that the Dealer is eligible for, which has \nbeen set by the Admin beforehand.\n\nOnce the bill is generated, the Dealer will be notified \nand given access to it. The Dealer will then review \nthe bill, ensuring that it reflects the correct item and \nquantity, as well as the agreed-upon discount. If the \nDealer is satisfied with the bill, they will proceed to \npurchase the item at the discounted price.\n\nThe Admin, meanwhile, will keep track of all bills and \npurchases made by Dealers. They will also manage \nthe discounts, ensuring that they are updated and \nreflect the latest agreements between the Admin \nand the Dealers.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Color(0xff2222222),
                                fontSize: 15,
                                fontFamily: "Athiti",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                Card(
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    color: const Color(0xFF6BA444).withOpacity(0.75),
                    child: ExpansionTile(
                      title: const Text(
                        "Is your payment platform secure?",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.8,
                          fontFamily: "Cambay",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: Color(0xFFFFFFFF),
                      ),
                      children: [
                        Container(
                          color: const Color(0xFFFFFFFF),
                          height: UiHelper.displayHeight(context) * 0.268,
                          width: UiHelper.displayWidth(context) * 0.939,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "The payment platform being used for this system is \nconsidered to be the safest one available. To make \na payment, the dealers will have several options \nincluding cash, cheques, e-wallets, and bank \ntransfers. When it comes time for a dealer to make \na purchase, they will provide payment to the admin \ndirectly using one of these methods. This ensures \nthat the transaction is secure and that there is no \nrisk of unauthorized access to sensitive \nfinancial information.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Color(0xff2222222),
                                fontSize: 15,
                                fontFamily: "Athiti",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                Card(
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    color: const Color(0xFF6BA444).withOpacity(0.75),
                    child: ExpansionTile(
                      title: const Text("Can I get an invoice for my order?",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16.8,
                            fontFamily: "Cambay",
                            fontWeight: FontWeight.w600,
                          )),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: Color(0xFFFFFFFF),
                      ),
                      children: [
                        Container(
                          color: const Color(0xFFFFFFFF),
                          height: UiHelper.displayHeight(context) * 0.065,
                          width: UiHelper.displayWidth(context) * 0.939,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Yes, you will get an invoice for your order.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Color(0xff2222222),
                                fontSize: 15,
                                fontFamily: "Athiti",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                Card(
                    margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                    color: const Color(0xFF6BA444).withOpacity(0.75),
                    child: ExpansionTile(
                      title: const Text(
                        "Can other info be added to an invoice?",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.8,
                          fontFamily: "Cambay",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: Color(0xFFFFFFFF),
                      ),
                      children: [
                        Container(
                          color: const Color(0xFFFFFFFF),
                          height: UiHelper.displayHeight(context) * 0.105,
                          width: UiHelper.displayWidth(context) * 0.939,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Yes, other info can be added to an invoice. But, you \nwill need to contact to Admin for adding other info \nto your invoice.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Color(0xff2222222),
                                fontSize: 15,
                                fontFamily: "Athiti",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
                Card(
                    margin: const EdgeInsets.only(
                        top: 12, left: 12, right: 12, bottom: 14),
                    color: const Color(0xFF6BA444).withOpacity(0.75),
                    child: ExpansionTile(
                      title: const Text(
                        "How do I change my account email and password?",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16.8,
                          fontFamily: "Cambay",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 28,
                        color: Color(0xFFFFFFFF),
                      ),
                      children: [
                        Container(
                          color: const Color(0xFFFFFFFF),
                          height: UiHelper.displayHeight(context) * 0.24,
                          width: UiHelper.displayWidth(context) * 0.939,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "If you want to change your email or password on this \nplatform, you will need to contact the Admin. They \nwill provide you with the necessary steps to make \nthe changes. It is important to keep your login \ncredentials secure and to update them periodically \nto maintain the security of your account. By \ncontacting the Admin, you can ensure that the \nprocess of changing your email or password is \ndone smoothly and securely.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Color(0xff2222222),
                                fontSize: 15,
                                fontFamily: "Athiti",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),
          )))
        ],
      ),
    );
  }
}
