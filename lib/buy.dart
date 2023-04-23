import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFd81921),
      body: Column(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            heightFactor: 2.75,
            child: Image.asset(
              "images/logos.jpg",
              width: 170,
              height: 120,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 45.0,
            width: 170.2,
            margin: const EdgeInsets.only(top: 166, bottom: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(
                    255, 255, 255, 255), //background color of button
                //border width and color

                shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(50.5)),
              ),
              child: const Text(
                "LOGIN",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.25,
                    letterSpacing: 1,
                    fontFamily: "RussoOne",
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 255, 0, 13),
                    fontSize: 22),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/third');
              },
            ),
          ),
          const Divider(
            thickness: 2.2, // thickness of the line
            indent: 0, // empty space to the leading edge of divider.
            endIndent: 0, // empty space to the trailing edge of the divider.
            color: Color.fromARGB(
                255, 255, 255, 255), // The color to use when painting the line.
            height: 20.5, // The divider's height extent.
          ),
          Container(
            height: 45.0,
            width: 170.2,
            margin: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
                //border width and color

                shape: RoundedRectangleBorder(
                    //to set border radius to button
                    borderRadius: BorderRadius.circular(50.5)),
              ),
              child: const Text(
                "BUY",
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.25,
                    letterSpacing: 1,
                    fontFamily: "RussoOne",
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 255, 0, 13),
                    fontSize: 22),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
