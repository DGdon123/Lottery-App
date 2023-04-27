import 'dart:async';
import 'package:ecommerce/ui_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
                width: UiHelper.displayWidth(context) * 0.58,
                height: UiHelper.displayHeight(context) * 0.62,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'images/logos.png',
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: LoadingAnimationWidget.discreteCircle(
                  secondRingColor: const Color(0xFF6BA444),
                  thirdRingColor: const Color(0xFFFCD62D),
                  size: UiHelper.displayWidth(context) * 0.08,
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
