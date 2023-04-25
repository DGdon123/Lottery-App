import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'controllers/bottom_nav_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(BottomNavController());
    return GetBuilder<BottomNavController>(builder: (context) {
      return Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: context.offset,
                end: Offset.zero,
              ).animate(
                (CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                )),
              ),
              child: child,
            );
          },
          child: context.screens[context.selectedIndex],
        ),
        bottomNavigationBar: Container(
          //  padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            //  color: blue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(
                color: Color(0xFFFFFFFF),
                width: 0.25,
              ),
            )),
            child: GNav(
              rippleColor: const Color(0xFFFFFFFF),
              hoverColor: const Color(0xFF6BA444).withOpacity(0.4),
              haptic: true,
              tabBorderRadius: 40,
              curve: Curves.easeInCirc,
              duration: const Duration(milliseconds: 300),
              gap: 8,
              color: const Color(0xFF222222).withOpacity(0.7),
              activeColor: const Color(0xFFFFFFFF),
              iconSize: 24,
              tabBackgroundColor: const Color(0xFF6BA444).withOpacity(0.85),
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
              tabMargin: const EdgeInsets.only(left: 20, right: 20),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.history_rounded,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ],
              onTabChange: (index) {
                context.changeIndex(index);
              },
            ),
          ),
        ),
      );
    });
  }
}
