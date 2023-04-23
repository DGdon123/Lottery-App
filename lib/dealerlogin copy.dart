import 'dart:convert';

import 'package:ecommerce/services/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dealer.dart';

class FifthScreen extends StatefulWidget {
  const FifthScreen({Key? key}) : super(key: key);
  @override
  State<FifthScreen> createState() => _FifthScreenState();
}

class _FifthScreenState extends State<FifthScreen> {
  var size, height, width;
  bool _isObscure = true;
  final storage = FlutterSecureStorage();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() async {
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
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const FourthScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      final logInErrorBar = SnackBar(
        content: Text(
          "Invalid Email or Password!!!!!",
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
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Column(children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
                        child: Column(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 2.92,
                  child: Image.asset(
                    "images/logo.png",
                    width: width * 0.4,
                    height: height * 0.14,
                    fit: BoxFit.fill,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 2.25,
                  child: Text(
                    "Sign In to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: height * 0.0015,
                      letterSpacing: 0.3,
                      fontFamily: "KumbhSans",
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFd81921),
                      fontSize: width * 0.062,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Container(
                        width: width * 0.72,
                        child: TextFormField(
                          controller: emailController,
                          maxLines: 1,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 204, 0),
                            suffixIcon: Icon(
                              Icons.mail_rounded,
                              color: Color(0xFF271C24),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 247, 199, 11),
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(11.5),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 247, 199, 11),
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(11.5),
                              ),
                            ),
                            labelText: 'Email',
                            hintText: 'Enter Your Email',
                            hintStyle: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF271C24),
                              fontSize: width * 0.043,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF271C24),
                              fontSize: width * 0.047,
                            ),
                            suffixIconColor: Color.fromARGB(255, 255, 0, 0),
                          ),
                          style: TextStyle(
                              fontSize: width * 0.045,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0, 0, 0)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email field cannot be empty';
                            }
                            return '';
                          },
                        ),
                      ),
                      Container(
                        width: width * 0.72,
                        margin: const EdgeInsets.only(bottom: 38.5, top: 9),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: _isObscure,
                          maxLines: 1,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 204, 0),
                            suffixIcon: IconButton(
                                icon: Icon(
                                  _isObscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xFF271C24),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 204, 0),
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(11.5),
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 204, 0),
                                  width: 2,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(
                                Radius.circular(11.5),
                              ),
                            ),
                            labelText: 'Password',
                            hintText: 'Enter Your Password',
                            hintStyle: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF271C24),
                              fontSize: width * 0.043,
                            ),
                            labelStyle: TextStyle(
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF271C24),
                              fontSize: width * 0.047,
                            ),
                            suffixIconColor: Color.fromARGB(255, 255, 0, 0),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password field cannot be empty';
                            }
                            return '';
                          },
                          style: TextStyle(
                              fontSize: width * 0.045,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  heightFactor: 0.7,
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.3,
                    margin: const EdgeInsets.only(bottom: 5.7),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(
                            0xFF2E3532), //background color of button
                        //border width and color

                        shape: RoundedRectangleBorder(
                            //to set border radius to button
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: height * 0.001,
                          fontFamily: "ZenKakuGothicAntique",
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: width * 0.055,
                        ),
                      ),
                      onPressed: () {
                        if (emailController.text.isEmpty &&
                            passwordController.text.isEmpty) {
                          final emptyFieldErrorBar = SnackBar(
                            content: Text(
                              "Email and Password fields cannot be empty!",
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
                          ScaffoldMessenger.of(context)
                              .showSnackBar(emptyFieldErrorBar);
                        } else if (emailController.text.isEmpty) {
                          final emptyFieldErrorBar = SnackBar(
                            content: Text(
                              "Email field cannot be empty!",
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
                          ScaffoldMessenger.of(context)
                              .showSnackBar(emptyFieldErrorBar);
                        } else if (passwordController.text.isEmpty) {
                          final emptyFieldErrorBar = SnackBar(
                            content: Text(
                              "Password field cannot be empty!",
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
                          ScaffoldMessenger.of(context)
                              .showSnackBar(emptyFieldErrorBar);
                        } else {
                          // Call the login function
                          login();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ))))
          ]);
        }));
  }
}
