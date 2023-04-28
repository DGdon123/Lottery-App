import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var size, height, width;
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    checkTokenAndRedirect();
  }

  Future<void> checkTokenAndRedirect() async {
    String? token = await storage.read(key: 'token');
    if (token == null) {
      Get.offAllNamed('/third');
    } else {
      Timer(const Duration(seconds: 3), () => Get.toNamed('/third2'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 50.w,
                height: 30.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'images/logos.png',
                    ),
                  ),
                ),
              ),
              Container(
                height: 5.h,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: LoadingAnimationWidget.discreteCircle(
                  secondRingColor: const Color(0xFF6BA444),
                  thirdRingColor: const Color(0xFFFCD62D),
                  size: 20.sp,
                  color: const Color(0xFFFCD62D),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
