import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ThirdRoute extends StatelessWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 246, 248, 249),
          centerTitle: true,
          title: const Text('SAGUNPLY',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontFamily: 'Roboto Bold',
                fontSize: 24,
                fontWeight: FontWeight.w800,
              )),
          iconTheme: const IconThemeData(
            size: 30, //change size on your need
            color: Color.fromARGB(255, 0, 0, 0), //change color on your need
          ),
          elevation: 0,
          actions: [
            Container(
              width: 60,
              height: 20,
              padding: const EdgeInsets.only(top: 11),
              margin: const EdgeInsets.only(right: 11, bottom: 2),
              child: ClipRRect(
                // ignore: sort_child_properties_last
                child: Image.asset(
                  "images/logo.png",
                  width: 200,
                  height: 0.2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ]),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.5,
        // ignore: sort_child_properties_last
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.home_outlined,
                  color: Color.fromARGB(255, 24, 22, 22)),
              title: Text('Home',
                  style: TextStyle(color: Color.fromARGB(255, 24, 22, 22))),
            ),
            ListTile(
              leading: Icon(Icons.person_rounded,
                  color: Color.fromARGB(255, 24, 22, 22)),
              title: Text('About Us',
                  style: TextStyle(color: Color.fromARGB(255, 24, 22, 22))),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart,
                  color: Color.fromARGB(255, 24, 22, 22)),
              title: Text('Cart',
                  style: TextStyle(color: Color.fromARGB(255, 24, 22, 22))),
            ),
            ListTile(
              leading: Icon(Icons.account_circle,
                  color: Color.fromARGB(255, 24, 22, 22)),
              title: Text('Account',
                  style: TextStyle(color: Color.fromARGB(255, 24, 22, 22))),
            ),
            ListTile(
              leading:
                  Icon(Icons.settings, color: Color.fromARGB(255, 24, 22, 22)),
              title: Text('Settings',
                  style: TextStyle(color: Color.fromARGB(255, 24, 22, 22))),
            ),
            ListTile(
              leading: Icon(Icons.help_outline_rounded,
                  color: Color.fromARGB(255, 24, 22, 22)),
              title: Text('Help',
                  style: TextStyle(color: Color.fromARGB(255, 24, 22, 22))),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: 1525.75,
                width: 500.0,
                child: Container(
                  child: Column(
                    children: [
                      const Align(
                          heightFactor: 1.5,
                          alignment: Alignment.center,
                          child: Text(
                            "Welcome",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 51, 51, 52),
                              fontFamily: "Roboto-Black",
                              fontSize: 15,
                            ),
                          )),
                      CarouselSlider(
                        items: [
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/first.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/second.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/third.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/fourth.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/fifth.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/sixth.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/seventh.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/eighth.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6.3),
                            height: 300.0,
                            width: 395.0,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    "images/nineth.jpg",
                                  ),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7.8)),
                              gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromARGB(116, 0, 0, 0),
                                  Color.fromARGB(255, 0, 0, 0),
                                ],
                              ),
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          height: 160.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                      ),
                      const Align(
                          heightFactor: 2.2,
                          alignment: Alignment.center,
                          child: Text(
                            "PRODUCTS",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F2F2F),
                              fontFamily: "Roboto-Black",
                              fontSize: 30,
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1,
                        widthFactor: 2.1,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/hardwood.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(116, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        widthFactor: 2.1,
                        heightFactor: 0.00000001,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/first.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                          ),
                        ),
                      ),
                      const Align(
                          widthFactor: 2.25,
                          heightFactor: 1.4,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Hardwood Plywood",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                          widthFactor: 2.31,
                          heightFactor: 0.001,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Softwood Plywood",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1.01,
                        widthFactor: 12.9,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00000000001,
                        widthFactor: 14.88,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 10.89,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00001,
                        widthFactor: 6.82,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 14.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 12.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 10.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.00001,
                        widthFactor: 6.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                          widthFactor: 3.72,
                          heightFactor: 1,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Rs: 5,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      const Align(
                          widthFactor: 3.75,
                          heightFactor: 0.1,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Rs: 2,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      Align(
                        heightFactor: 0.11,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1,
                        widthFactor: 2.1,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/third.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(116, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        widthFactor: 2.1,
                        heightFactor: 0.00000001,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/second.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                          ),
                        ),
                      ),
                      const Align(
                          widthFactor: 2.49,
                          heightFactor: 1.4,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Marine Plywood",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                          widthFactor: 2.45,
                          heightFactor: 0.001,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Exterior Plywood",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1.01,
                        widthFactor: 12.9,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00000000001,
                        widthFactor: 14.88,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 10.89,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00001,
                        widthFactor: 6.82,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 14.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 12.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 10.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.00001,
                        widthFactor: 6.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                          widthFactor: 3.47,
                          heightFactor: 1,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Rs: 25,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      const Align(
                          widthFactor: 3.42,
                          heightFactor: 0.1,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Rs: 15,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      Align(
                        heightFactor: 0.11,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1,
                        widthFactor: 2.1,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/structure.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(116, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        widthFactor: 2.1,
                        heightFactor: 0.00000001,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/fourth.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                          ),
                        ),
                      ),
                      const Align(
                          widthFactor: 2.26,
                          heightFactor: 1.4,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Structural Plywood",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                          widthFactor: 2.43,
                          heightFactor: 0.001,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Overlaid Plywood",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1.01,
                        widthFactor: 12.9,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00000000001,
                        widthFactor: 14.88,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 10.89,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00001,
                        widthFactor: 6.82,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 14.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 12.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 10.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.00001,
                        widthFactor: 6.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                          widthFactor: 3.47,
                          heightFactor: 1,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Rs: 40,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      const Align(
                          widthFactor: 3.78,
                          heightFactor: 0.1,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Rs: 4,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      Align(
                        heightFactor: 0.11,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1,
                        widthFactor: 2.1,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/seventh.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(116, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        widthFactor: 2.1,
                        heightFactor: 0.00000001,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/sixth.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                          ),
                        ),
                      ),
                      const Align(
                          widthFactor: 2.18,
                          heightFactor: 1.4,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Blockboard Plywood",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                          widthFactor: 2.34,
                          heightFactor: 0.001,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Composite Woods",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1.01,
                        widthFactor: 12.9,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00000000001,
                        widthFactor: 14.88,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 10.89,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00001,
                        widthFactor: 6.82,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 14.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 12.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 10.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.00001,
                        widthFactor: 6.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                          widthFactor: 3.37,
                          heightFactor: 1,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Rs: 10,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      const Align(
                          widthFactor: 3.47,
                          heightFactor: 0.1,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Rs: 18,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      Align(
                        heightFactor: 0.11,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1,
                        widthFactor: 2.1,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/nineth.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(116, 0, 0, 0),
                                Color.fromARGB(255, 0, 0, 0),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        widthFactor: 2.1,
                        heightFactor: 0.00000001,
                        child: Container(
                          height: 140.0,
                          width: 177.0,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "images/eighth.jpg",
                                ),
                                fit: BoxFit.cover),
                            borderRadius:
                                BorderRadius.all(Radius.circular(7.8)),
                          ),
                        ),
                      ),
                      const Align(
                          widthFactor: 2.74,
                          heightFactor: 1.4,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Particleboard",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                          widthFactor: 3.15,
                          heightFactor: 0.001,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Foamboard",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFd81921),
                              fontFamily: "Roboto-Black",
                              fontSize: 18,
                            ),
                          )),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 1.01,
                        widthFactor: 12.9,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00000000001,
                        widthFactor: 14.88,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 10.89,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.00001,
                        widthFactor: 6.82,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomRight,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 14.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 12.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFff9933)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 10.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.01,
                        widthFactor: 8.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        heightFactor: 0.00001,
                        widthFactor: 6.85,
                        child: Icon(Icons.grade_rounded,
                            size: 20, color: Color(0xFFd6d6d6)),
                      ),
                      const Align(
                          widthFactor: 3.78,
                          heightFactor: 1,
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Rs: 1,500",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      const Align(
                          widthFactor: 3.78,
                          heightFactor: 0.1,
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Rs: 1,000",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Roboto-Black",
                              fontSize: 17,
                            ),
                          )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        heightFactor: 1.1,
                        widthFactor: 02,
                        child: Container(
                            height: 122.9,
                            width: 500.0,
                            color: const Color(0xFFEDDFEF),
                            child: Column(
                              children: [
                                const Align(
                                    widthFactor: 2.65,
                                    heightFactor: 1.35,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Phone Number",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA8763E),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 17,
                                      ),
                                    )),
                                const Align(
                                    widthFactor: 2.5,
                                    heightFactor: 0.01,
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Email Address",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA8763E),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 17,
                                      ),
                                    )),
                                const Align(
                                    widthFactor: 3.35,
                                    heightFactor: 1.2,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "041- 521 640",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF472D30),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 13.5,
                                      ),
                                    )),
                                const Align(
                                    widthFactor: 2.2,
                                    heightFactor: 0.01,
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "info@sagunply.com.np",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF472D30),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 13.5,
                                      ),
                                    )),
                                const Align(
                                    heightFactor: 1.45,
                                    widthFactor: 3.39,
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "Follow US",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFA8763E),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 17,
                                      ),
                                    )),
                                const Align(
                                    widthFactor: 2.88,
                                    heightFactor: 0.00001,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Address Info",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFFA8763E),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 17,
                                      ),
                                    )),
                                const Align(
                                    widthFactor: 2.4,
                                    heightFactor: 1.16,
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      "Janakpurdham, Nepal",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF472D30),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 13.5,
                                      ),
                                    )),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  widthFactor: 14.15,
                                  heightFactor: 0.3,
                                  child: Container(
                                    height: 16.0,
                                    width: 18.0,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "images/yt.png",
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  widthFactor: 6.78,
                                  heightFactor: 0.1,
                                  child: Container(
                                    height: 21.0,
                                    width: 22.0,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "images/fb.png",
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  widthFactor: 8.6,
                                  heightFactor: 0.07,
                                  child: Container(
                                    height: 24.0,
                                    width: 24.0,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            "images/insta.png",
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                                const Align(
                                    heightFactor: 1.5,
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      "© SAGUNPLY 2022",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: "Roboto-Black",
                                        fontSize: 11,
                                      ),
                                    )),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 246, 248, 249),
        iconSize: 28,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Color.fromARGB(255, 0, 0, 0),
        selectedFontSize: 12,
        onTap: (value) {
          if (value == 0) Navigator.pushNamed(context, '/fourth');
          if (value == 1) Navigator.pushNamed(context, '/fifth');
          if (value == 2) Navigator.pushNamed(context, '/third');
          if (value == 3) Navigator.pushNamed(context, '/seventh');
          if (value == 4) Navigator.pushNamed(context, '/third');
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.messenger_sharp,
              ),
              label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
              ),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Account"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.logout_outlined,
              ),
              label: "Logout")
        ],
      ),
    );
  }
}
