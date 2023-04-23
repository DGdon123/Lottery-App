import 'package:ecommerce/dealer.dart';
import 'package:ecommerce/help.dart';
import 'package:ecommerce/history.dart';
import 'package:ecommerce/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int selectedIndex = 0;
  Offset offset = const Offset(1, 0);
  final List<Widget> screens = [
    const FourthScreen(),
    const History(),
    const EighthScreen(),
    const FourthRoute(),
  ];

  changeIndex(index) {
    if (index > selectedIndex) {
      offset = const Offset(1, 0);
    } else {
      offset = const Offset(-1, 0);
    }
    selectedIndex = index;
    update();
  }
}
