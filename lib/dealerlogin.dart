import 'dart:convert';

import 'package:ecommerce/services/api.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dealer.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({Key? key}) : super(key: key);
  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  var size, height, width;
  final bool _isButtonDisabled = true;
  final bool _rememberMe = false;
  bool _isObscure = true;
  bool _clicked = false;
  final storage = const FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Color originalButtonColor = const Color(0xFF6BA444).withOpacity(0.75);
  Color? _buttonColor;
  final String _email = '';
  final String _password = '';

  @override
  void initState() {
    super.initState();
    _buttonColor = originalButtonColor;
  }

  Future<void> login() async {
    var data = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    var res = await CallApi().postData(data, 'login');
    var body = json.decode(res.body);

    if (body['success']) {
      String token = body['data']['token'];
      storeToken(token);
      String? retrievedToken = await retrieveToken();
      setState(() {
        _clicked = true;
        _buttonColor = const Color(0xFF6BA444);
      });

      if (retrievedToken != null) {
        Get.toNamed('/third2');

        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          _clicked = false;
          _buttonColor = originalButtonColor;
        });
      } else {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Session Expired',
          text: 'Your session has expired. Please log in again.',
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Invalid Email and Password!",
        backgroundColor: Colors.red.shade400,
        colorText: const Color.fromARGB(255, 255, 255, 255),
        duration: const Duration(milliseconds: 3000),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        borderWidth: 2,
        borderColor: Colors.red,
        animationDuration: const Duration(milliseconds: 400),
      );

      setState(() {
        _clicked = true;
        _buttonColor = const Color(0xFF6BA444);
      });
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _clicked = false;
        _buttonColor = originalButtonColor;
      });
    }
  }

  Future<void> storeToken(String token) async {
    final expirationDate = DateTime.now().add(const Duration(days: 30));
    await storage.write(key: 'token', value: token);
    await storage.write(
        key: 'tokenExpiration', value: expirationDate.toIso8601String());
  }

  Future<String?> retrieveToken() async {
    final tokenExpirationString = await storage.read(key: 'tokenExpiration');
    if (tokenExpirationString != null) {
      final tokenExpiration = DateTime.parse(tokenExpirationString);
      if (tokenExpiration.isAfter(DateTime.now())) {
        final token = await storage.read(key: 'token');
        return token;
      } else {
        await storage.delete(key: 'token');
        await storage.delete(key: 'tokenExpiration');
        return null;
      }
    } else {
      final token = await storage.read(key: 'token');
      return token;
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            Expanded(
                child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context)
                        .copyWith(scrollbars: false),
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                height: 13.5.h,
                              ),
                              Image.asset(
                                "images/logos.png",
                                width: 40.w,
                                height: 15.h,
                                fit: BoxFit.fill,
                              ),
                              Container(
                                height: 6.2.h,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8.w,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                            letterSpacing: 0.1,
                                            fontFamily: "NotoSans",
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xFF222222),
                                            fontSize: 23.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 1.37.h,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 8.w,
                                      ),
                                      Container(
                                        child: Text(
                                          "Please sign in to continue.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            letterSpacing: 0.1,
                                            fontFamily: "KumbhSans",
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize: 17.8.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 6.6.h,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 8.w,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFFFFFF),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 0),
                                                    blurRadius: 5.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                              width: 83.w,
                                              child: TextFormField(
                                                controller: emailController,
                                                maxLines: 1,
                                                cursorColor:
                                                    const Color(0xFFA6AEB0),
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(
                                                    Icons.mail_outline_rounded,
                                                    color: Color(0xFFA6AEB0),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    //Before Click display
                                                    borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.2), //borderline opacity lightcolored
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(2),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    //After Click Display
                                                    borderSide: BorderSide(
                                                        color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                234,
                                                                228,
                                                                228)
                                                            .withOpacity(0.2),
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(2),
                                                    ),
                                                  ),
                                                  labelText: 'Email',
                                                  hintText: 'Enter Your Email',
                                                  hintStyle: TextStyle(
                                                    height: 0.1.h,
                                                    fontFamily: "Mulish",
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFFA6AEB0),
                                                    fontSize: 17.2.sp,
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontFamily: "Mulish",
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFFA6AEB0),
                                                    fontSize: 17.2.sp,
                                                  ),
                                                  suffixIconColor:
                                                      const Color.fromARGB(
                                                          255, 255, 0, 0),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 17.2.sp,
                                                  fontFamily: "Mulish",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Email field cannot be empty';
                                                  }
                                                  return '';
                                                },
                                              ),
                                            ),
                                            Container(
                                              height: 1.65.h,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFFFFFF),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    offset: const Offset(0, 0),
                                                    blurRadius: 5.0,
                                                    spreadRadius: 0.0,
                                                  ), //BoxShadow
                                                  //BoxShadow
                                                ],
                                              ),
                                              width: 83.w,
                                              child: TextFormField(
                                                controller: passwordController,
                                                obscureText: _isObscure,
                                                maxLines: 1,
                                                cursorColor:
                                                    const Color(0xFFA6AEB0),
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                decoration: InputDecoration(
                                                  prefixIcon: IconButton(
                                                      icon: Icon(
                                                        _isObscure
                                                            ? Icons
                                                                .lock_outline_rounded
                                                            : Icons
                                                                .lock_open_rounded,
                                                        color: const Color(
                                                            0xFFA6AEB0),
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          _isObscure =
                                                              !_isObscure;
                                                        });
                                                      }),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    //Before Click display
                                                    borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .withOpacity(
                                                                0.2), //borderline opacity lightcolored
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(2),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    //After Click Display
                                                    borderSide: BorderSide(
                                                        color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                234,
                                                                228,
                                                                228)
                                                            .withOpacity(0.2),
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(2),
                                                    ),
                                                  ),
                                                  labelText: 'Password',
                                                  hintText:
                                                      'Enter Your Password',
                                                  hintStyle: TextStyle(
                                                    height: 0.1.h,
                                                    fontFamily: "Mulish",
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFFA6AEB0),
                                                    fontSize: 17.2.sp,
                                                  ),
                                                  labelStyle: TextStyle(
                                                    fontFamily: "Mulish",
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFFA6AEB0),
                                                    fontSize: 17.2.sp,
                                                  ),
                                                  suffixIconColor:
                                                      const Color.fromARGB(
                                                          255, 255, 0, 0),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Password field cannot be empty';
                                                  }
                                                  return '';
                                                },
                                                style: TextStyle(
                                                  fontSize: 17.2.sp,
                                                  fontFamily: "Mulish",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 8.w,
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 22),
                                          width: 23.w,
                                          height: 0.05.h,
                                          color: const Color(0xff2222222)),
                                      Container(
                                        width: 2.45.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/line');
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(top: 6),
                                          child: const Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              "Forgot Password?",
                                              style: TextStyle(
                                                fontFamily: "Cairo",
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF222222),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 2.w,
                                      ),
                                      Container(
                                          margin:
                                              const EdgeInsets.only(top: 22),
                                          width: 23.w,
                                          height: 0.05.h,
                                          color: const Color(0xff2222222)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: height * 0.072,
                                        width: width * 0.36,
                                        margin: const EdgeInsets.only(top: 50),
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                              ),
                                              backgroundColor: _clicked
                                                  ? MaterialStateProperty.all<
                                                      Color>(
                                                      const Color(0xFF6BA444)
                                                          .withOpacity(0.75),
                                                    )
                                                  : MaterialStateProperty.all<
                                                      Color>(_buttonColor!),
                                            ),
                                            onPressed: _clicked
                                                ? null
                                                : () async {
                                                    setState(
                                                        () => _clicked = true);
                                                    if (emailController
                                                            .text.isEmpty &&
                                                        passwordController
                                                            .text.isEmpty) {
                                                      Get.snackbar(
                                                        "Error",
                                                        "Email and Password fields cannot be empty",
                                                        backgroundColor:
                                                            Colors.red.shade400,
                                                        colorText: const Color
                                                                .fromARGB(
                                                            255, 255, 255, 255),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    2000),
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        borderRadius: 10,
                                                        borderWidth: 2,
                                                        borderColor: Colors.red,
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                      );

                                                      setState(() =>
                                                          _clicked = true);
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 2));
                                                      setState(() =>
                                                          _clicked = false);
                                                    } else if (emailController
                                                        .text.isEmpty) {
                                                      Get.snackbar(
                                                        "Error",
                                                        "Email field cannot be empty",
                                                        backgroundColor:
                                                            Colors.red.shade400,
                                                        colorText: const Color
                                                                .fromARGB(
                                                            255, 255, 255, 255),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    3000),
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        borderRadius: 10,
                                                        borderWidth: 2,
                                                        borderColor: Colors.red,
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                      );

                                                      setState(() =>
                                                          _clicked = true);
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 2));
                                                      setState(() =>
                                                          _clicked = false);
                                                    } else if (passwordController
                                                        .text.isEmpty) {
                                                      Get.snackbar(
                                                        "Error",
                                                        "Password field cannot be empty",
                                                        backgroundColor:
                                                            Colors.red.shade400,
                                                        colorText: const Color
                                                                .fromARGB(
                                                            255, 255, 255, 255),
                                                        duration:
                                                            const Duration(
                                                                milliseconds:
                                                                    3000),
                                                        snackPosition:
                                                            SnackPosition
                                                                .BOTTOM,
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        borderRadius: 10,
                                                        borderWidth: 2,
                                                        borderColor: Colors.red,
                                                        animationDuration:
                                                            const Duration(
                                                                milliseconds:
                                                                    400),
                                                      );

                                                      setState(() =>
                                                          _clicked = true);
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 2));
                                                      setState(() =>
                                                          _clicked = false);
                                                    } else {
                                                      login();
                                                    }
                                                    setState(
                                                        () => _clicked = false);
                                                  },
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: width * 0.030,
                                                ),
                                                Text(
                                                  "LOGIN",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    height: height * 0.0017,
                                                    fontFamily: "Cabin",
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        const Color(0xFFFFFFFF),
                                                    fontSize: width * 0.042,
                                                  ),
                                                ),
                                                Container(
                                                  width: width * 0.045,
                                                ),
                                                Icon(
                                                  Icons.east_rounded,
                                                  size: UiHelper.displayWidth(
                                                          context) *
                                                      0.065,
                                                  color:
                                                      const Color(0xFFFFFFFF),
                                                )
                                              ],
                                            )),
                                      ),
                                      Container(
                                        width: width * 0.085,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ))))
          ]);
        }));
  }
}
