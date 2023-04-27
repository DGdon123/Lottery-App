import 'dart:convert';

import 'package:ecommerce/services/api.dart';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'dealer.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  var size, height, width;
  final bool _isButtonDisabled = true;
  final bool _rememberMe = false;
  final bool _isObscure = true;
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
      retrieveToken();
      setState(() {
        _clicked = true;
        _buttonColor = const Color(0xFF6BA444).withOpacity(0.75);
      });

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const FourthScreen()),
        (Route<dynamic> route) => false,
      );
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _clicked = false;
        _buttonColor = originalButtonColor;
      });
    } else {
      const logInErrorBar = SnackBar(
        content: Text(
          "Invalid Email or Password",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            fontFamily: 'Nunito',
          ),
          textAlign: TextAlign.center,
        ),
        duration: Duration(milliseconds: 1400),
        backgroundColor: Color(0xFF6BA444),
      );
      ScaffoldMessenger.of(context).showSnackBar(logInErrorBar);
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

  storeToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  retrieveToken() async {
    String? token = await storage.read(key: 'token');
    print(token);
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
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height / 8.5,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                heightFactor: height * 0.00258,
                                child: Image.asset(
                                  "images/logos.png",
                                  width: 155,
                                  height: 105,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              UiHelper.verticalSpace(vspace: Spacing.xxlarge),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.081,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        child: Text(
                                          "Reset Password",
                                          style: TextStyle(
                                            height: height * 0.0015,
                                            letterSpacing: 0.1,
                                            fontFamily: "NotoSans",
                                            fontWeight: FontWeight.w900,
                                            color: const Color(0xFF222222),
                                            fontSize: width * 0.055,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.081,
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 12),
                                        child: Text(
                                          "Please enter your email to reset your password.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            letterSpacing: 0.1,
                                            fontFamily: "KumbhSans",
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFFA6AEB0),
                                            fontSize: width * 0.036,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: width * 0.081,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomLeft,
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Column(children: [
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
                                            width: width * 0.832,
                                            child: TextFormField(
                                              controller: emailController,
                                              maxLines: 1,
                                              cursorColor:
                                                  const Color(0xFFA6AEB0),
                                              keyboardType:
                                                  TextInputType.visiblePassword,
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
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(2),
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  //After Click Display
                                                  borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                                  255,
                                                                  234,
                                                                  228,
                                                                  228)
                                                              .withOpacity(0.2),
                                                      width: 1,
                                                      style: BorderStyle.solid),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(2),
                                                  ),
                                                ),
                                                labelText: 'Email',
                                                hintText: 'somebody@trulam.com',
                                                hintStyle: TextStyle(
                                                  height: height * 0.0023,
                                                  fontFamily: "Mulish",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                  fontSize: width * 0.043,
                                                ),
                                                labelStyle: TextStyle(
                                                  fontFamily: "Mulish",
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      const Color(0xFFA6AEB0),
                                                  fontSize: width * 0.047,
                                                ),
                                                suffixIconColor:
                                                    const Color.fromARGB(
                                                        255, 255, 0, 0),
                                              ),
                                              style: TextStyle(
                                                fontSize: width * 0.045,
                                                fontFamily: "Mulish",
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFFA6AEB0),
                                              ),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Email field cannot be empty';
                                                }
                                                return '';
                                              },
                                            ),
                                          ),
                                        ]),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: height * 0.038,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        height: height * 0.072,
                                        width: width * 0.36,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                    width: 2,
                                                    color: Color(0xFF6BA444),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(28),
                                                ),
                                              ),
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(
                                                const Color(0xFFFFFFFF),
                                              )),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.west_rounded,
                                                size: UiHelper.displayWidth(
                                                        context) *
                                                    0.065,
                                                color: const Color(0xFF6BA444)
                                                    .withOpacity(0.75),
                                              ),
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
                                                  color: const Color(0xFF6BA444)
                                                      .withOpacity(0.75),
                                                  fontSize: width * 0.042,
                                                ),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.12,
                                      ),
                                      SizedBox(
                                        height: height * 0.072,
                                        width: width * 0.36,
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
                                                      const emptyFieldErrorBar =
                                                          SnackBar(
                                                        content: Text(
                                                          "Email field cannot be empty",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Nunito',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 1400),
                                                        backgroundColor:
                                                            Color(0xFF6BA444),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              emptyFieldErrorBar);
                                                      setState(() =>
                                                          _clicked = true);
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 2));
                                                      setState(() =>
                                                          _clicked = false);
                                                    } else if (emailController
                                                        .text.isEmpty) {
                                                      const emptyFieldErrorBar =
                                                          SnackBar(
                                                        content: Text(
                                                          "Email field cannot be empty",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Nunito',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 1400),
                                                        backgroundColor:
                                                            Color(0xFF6BA444),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              emptyFieldErrorBar);
                                                      setState(() =>
                                                          _clicked = true);
                                                      await Future.delayed(
                                                          const Duration(
                                                              seconds: 2));
                                                      setState(() =>
                                                          _clicked = false);
                                                    } else if (passwordController
                                                        .text.isEmpty) {
                                                      const emptyFieldErrorBar =
                                                          SnackBar(
                                                        content: Text(
                                                          "Password field cannot be empty",
                                                          style: TextStyle(
                                                            color: Color(
                                                                0xFFFFFFFF),
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                'Nunito',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 1400),
                                                        backgroundColor:
                                                            Color(0xFF6BA444),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              emptyFieldErrorBar);
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
                                                  "RESET",
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
                        )))
              ]);
        }));
  }
}
