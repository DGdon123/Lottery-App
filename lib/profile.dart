// ignore_for_file: unnecessary_new

import 'dart:core';
import 'dart:io';

import 'package:ecommerce/NetworkHandler.dart';
import 'package:ecommerce/models/pay.dart';
import 'package:ecommerce/services/epi.dart';
import 'package:ecommerce/services/help.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:ecommerce/services/network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecommerce/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:ecommerce/models/profile.dart';
import 'package:badges/badges.dart' as badges;
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'controllers/signup_controller.dart';
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
  File? _imagePath;
  NetworkHandler networkHandler = NetworkHandler();
  Account hell = Account(
      creditBalance: '', discount: '0', deliveryCharge: 0, companyName: '');

  Post profileModel = Post();
  String creditBalance = "0.00";
  SignUpController signUpController = Get.put(SignUpController());
  SignUpController signUp = Get.find();
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

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Take a photo'),
                  onTap: () async {
                    final pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera, imageQuality: 100);
                    if (pickedFile != null) {
                      // Save the image to disk or use it in your app
                      _imagePath = File(pickedFile.path);
                      signUp.setProfileImagePath(_imagePath!.path);
                      // Do whatever you want with the image file here
                    }
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Choose from gallery'),
                  onTap: () async {
                    final pickedFile = await ImagePicker().getImage(
                      source: ImageSource.gallery,
                    );
                    if (pickedFile != null) {
                      // Save the image to disk or use it in your app
                      _imagePath = File(pickedFile.path);
                      signUp.setProfileImagePath(_imagePath!.path);
                      // Do whatever you want with the image file here
                    }
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
          title: Text('Profile',
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontFamily: 'Nunito',
                fontSize: 19.2.sp,
                height: 0.16.h,
                letterSpacing: 0.4,
                fontWeight: FontWeight.w900,
              )),
          iconTheme: const IconThemeData(
            size: 30, //change size on your need
            color: Color(0xFFFFFFFF), //change color on your need
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: IconButton(
                icon: const Icon(
                  Icons.logout_rounded,
                  size: 22,
                ),
                tooltip: 'Open shopping cart',
                onPressed: () {
                  QuickAlert.show(
                    context: context,
                    onConfirmBtnTap: () {
                      Get.offAllNamed('/third');
                    },
                    type: QuickAlertType.confirm,
                    text: 'Do you want to logout',
                    confirmBtnText: 'Yes',
                    cancelBtnText: 'No',
                    confirmBtnColor: const Color(0xFF6BA444),
                  );
                },
              ),
            ),
          ],
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
                : Stack(children: [
                    Container(
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Color(0xFF6BA444),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        children: [
                          SizedBox(
                            height: UiHelper.displayHeight(context) * 0.001,
                          ),
                          badges.Badge(
                              position: badges.BadgePosition.bottomEnd(
                                  bottom: 3, end: 3),
                              showBadge: true,
                              ignorePointer: false,
                              onTap: () {
                                _pickImage();
                              },
                              badgeContent: Icon(Icons.camera_alt_outlined,
                                  color: Colors.white, size: 16.5.sp),
                              badgeAnimation:
                                  const badges.BadgeAnimation.rotation(
                                animationDuration: Duration(seconds: 1),
                                colorChangeAnimationDuration:
                                    Duration(seconds: 1),
                                loopAnimation: false,
                                curve: Curves.fastOutSlowIn,
                                colorChangeAnimationCurve: Curves.easeInCubic,
                              ),
                              badgeStyle: badges.BadgeStyle(
                                badgeColor: Colors.grey,
                                padding: const EdgeInsets.all(5),
                                borderRadius: BorderRadius.circular(4),
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 1.8),
                                elevation: 0,
                              ),
                              child: Obx(
                                () => CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: signUp
                                              .isProficPicPathSet.value ==
                                          true
                                      ? FileImage(
                                              File(signUp.profilePicPath.value))
                                          as ImageProvider
                                      : const AssetImage(
                                          "images/logos.png",
                                        ),
                                  radius: 30.sp,
                                ),
                              )),
                          SizedBox(
                            height: UiHelper.displayHeight(context) * 0.025,
                          ),
                          Text(
                            profileModel.name ?? ' ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Mulish",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFFFFFF),
                                fontSize: width * 0.080),
                          ),
                          UiHelper.verticalSpace(vspace: Spacing.medium),
                          SizedBox(
                            width: 44.5.w,
                            height: 6.5.h,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                    0xfffffffff), //background color of button
                                //border width and color

                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () {
                                Get.to(() => const NinethScreen(), arguments: [
                                  {'address': hell.address ?? ' '},
                                  {'email': profileModel.email ?? ' '},
                                  {'mobile': profileModel.phone ?? ' '},
                                  {'gift': "Rs: ${hell.creditLimit ?? ' '}"},
                                  {
                                    'name': profileModel.name ?? '',
                                  }
                                ])!
                                    .then((result) {
                                  if (result[0]["backValue"] == "one") {
                                    print("Result is coming");
                                  }
                                });
                              },
                              child: Text(
                                "EDIT PROFILE",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 0.165.h,
                                    fontFamily: "Carlito",
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF6BA444),
                                    fontSize: 18.5.sp),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Adaptive.h(4), // or 12.5.h
                            // or Adaptive.w(50)
                          ),
                          Container(
                            height: 31.3.h,
                            width: UiHelper.displayWidth(context) * 0.83,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFFFFF),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
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
                                UiHelper.verticalSpace(vspace: Spacing.medium),
                                Row(
                                  children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.large),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Icon(
                                          Icons.location_on_rounded,
                                          size: UiHelper.displayWidth(context) *
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
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
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
                                            alignment: Alignment.bottomLeft,
                                            width: width * 0.65,
                                            height: height * 0.03,
                                            child: Text(
                                              hell.address ?? ' ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  letterSpacing: 0.1,
                                                  fontFamily:
                                                      "SignikaNegative-Bold",
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                  height: UiHelper.displayHeight(context) *
                                      0.000090,
                                ),
                                UiHelper.verticalSpace(vspace: Spacing.medium),
                                Row(
                                  children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.large),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Icon(
                                          Icons.mail_rounded,
                                          size: UiHelper.displayWidth(context) *
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
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
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
                                            alignment: Alignment.bottomLeft,
                                            width: width * 0.65,
                                            height: height * 0.03,
                                            child: Text(
                                              profileModel.email ?? ' ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  letterSpacing: 0.1,
                                                  fontFamily:
                                                      "SignikaNegative-Bold",
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                                  height: UiHelper.displayHeight(context) *
                                      0.000090,
                                ),
                                UiHelper.verticalSpace(vspace: Spacing.medium),
                                Row(
                                  children: [
                                    UiHelper.horizontaSpace(
                                        hspace: Spacing.large),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Icon(
                                          Icons.phone_rounded,
                                          size: UiHelper.displayWidth(context) *
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
                                            color: const Color(0xFF222222),
                                            fontSize:
                                                UiHelper.displayWidth(context) *
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
                                            alignment: Alignment.bottomLeft,
                                            width: width * 0.65,
                                            height: height * 0.03,
                                            child: Text(
                                              profileModel.phone ?? ' ',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  letterSpacing: 0.1,
                                                  fontFamily:
                                                      "SignikaNegative-Bold",
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                  fontSize:
                                                      UiHelper.displayWidth(
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
                    )
                  ])));
  }
}
