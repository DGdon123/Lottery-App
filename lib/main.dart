import 'package:ecommerce/buy.dart';

import 'package:ecommerce/data_class.dart';
import 'package:ecommerce/dealerlogin.dart';
import 'package:ecommerce/forgot.dart';
import 'package:ecommerce/help.dart';
import 'package:ecommerce/homepage.dart';
import 'package:ecommerce/order.dart';
import 'package:ecommerce/orderplacement.dart';
import 'package:ecommerce/update.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'cart_provider.dart';
import 'checkout.dart';
import 'dealer.dart';

import 'details.dart';
import 'history.dart';
import 'invoice.dart';
import 'orderdetails.dart';
import 'splashscreen.dart';
import 'profile.dart';
import 'package:get/get.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => DataClass()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CartModel(),
        child: Theme(
            data: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.green,
            ),
            child: ResponsiveSizer(
              builder: (context, orientation, screenType) {
                return GetMaterialApp(
                  debugShowCheckedModeBanner: false,

                  // Start the app with the "/" named route. In this case, the app starts
                  // on the FirstScreen widget.
                  initialRoute: '/',
                  getPages: [
                    GetPage(
                      name: '/',
                      page: () => const MyHomePage(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transition: Transition.cupertino,
                    ),
                    GetPage(
                      name: '/line',
                      page: () => const PasswordScreen(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transition: Transition.cupertino,
                    ),
                    GetPage(
                      name: '/third',
                      page: () => const FifthScreen(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transition: Transition.fadeIn,
                    ),
                    GetPage(
                      name: '/third2',
                      page: () => const HomePage(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transition: Transition.fadeIn,
                    ),
                    GetPage(
                      name: '/third3',
                      page: () => const History(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transition: Transition.fadeIn,
                    ),
                    GetPage(
                      name: '/third4',
                      page: () => const Details(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transition: Transition.fadeIn,
                    ),
                    GetPage(
                      name: '/third5',
                      page: () => const NinethScreen(),
                      transitionDuration: const Duration(milliseconds: 600),
                      transition: Transition.fadeIn,
                    ),
                  ],
                  routes: {
                    // When navigating to the "/" routes, build the FirstScreen widget.
                    '/': (context) => const MyHomePage(),
                    '/second': (context) => const FirstScreen(),
                    '/third': (context) => const FifthScreen(),
                    '/third2/fourth': (context) => const FourthScreen(),
                    '/fifth': (context) => const SixthScreen(),
                    '/sixth': (context) => SixthRoute(
                          index: 0,
                          ring: const [],
                        ),
                    '/seventh': (context) => const SeventhScreen(),
                    '/eighth': (context) => const FourthRoute(),
                    '/tenth': (context) => const EighthScreen(),

                    '/tweleventh': (context) => const NinethRoute(),
                    '/thirteenth': (context) => TenthRoute(
                          index: 0,
                          ring: const [],
                        ),
                  },
                );
              },
              maxTabletWidth: 900, // Optional),
            )));
  }
}
