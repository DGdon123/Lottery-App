import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "images/business.jpg",
            ),
            fit: BoxFit.fitHeight),
        gradient: LinearGradient(
          begin: Alignment.center,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(116, 0, 0, 0),
            Color.fromARGB(255, 0, 0, 0),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Color(0xFFfdfefb),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          verticalDirection: VerticalDirection.down,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "images/logo.png",
                width: 160,
                height: 115,
                fit: BoxFit.fill,
              ),
            ),
            Align(
              heightFactor: 1.11,
              child: Container(
                height: 275.0,
                width: 255.0,
                margin: const EdgeInsets.all(0.1),
                padding: const EdgeInsets.all(0.1),
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFd81921),
                    borderRadius: const BorderRadius.all(Radius.circular(13.0)),
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        width: 2,
                        style: BorderStyle.solid),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "Log Into SAGUNPLY",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 2.1,
                            fontFamily: "SignikaNegative-Bold",
                            fontWeight: FontWeight.w900,
                            color: Color(0xFFD7F9F1),
                            fontSize: 19),
                      ),
                      const Text(
                        "Email",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 2.3,
                            fontFamily: "Roboto-Regular",
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16),
                      ),
                      Container(
                        height: 37.0,
                        width: 208.0,
                        margin: const EdgeInsets.all(0.1),
                        padding: const EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                              color: Color(0xFF5C573E),
                              width: 1.6,
                              style: BorderStyle.solid),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter your email',
                            labelStyle: TextStyle(
                                height: 4,
                                fontFamily: "SignikaNegative-Regular",
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      ),
                      const Text(
                        "Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 2,
                            fontFamily: "Roboto-Regular",
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 16),
                      ),
                      Container(
                        height: 37.0,
                        width: 208.0,
                        margin: const EdgeInsets.all(0.1),
                        padding: const EdgeInsets.all(0.1),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(
                              color: const Color(0xFF5C573E),
                              width: 1.6,
                              style: BorderStyle.solid),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter your password',
                            labelStyle: TextStyle(
                                height: 4,
                                fontFamily: "SignikaNegative-Regular",
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16),
                            contentPadding: EdgeInsets.all(8),
                            border: OutlineInputBorder(),
                          ),
                          style: TextStyle(fontSize: 14),
                          maxLines: 1,
                          minLines: 1,
                        ),
                      ),
                      Container(
                        height: 26.4,
                        width: 71,
                        margin: const EdgeInsets.all(17),
                        padding: const EdgeInsets.all(0.1),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 255, 255,
                                255), //background color of button
                            side: const BorderSide(
                                width: 2.1,
                                color: Color.fromARGB(
                                    255, 0, 0, 0)), //border width and color
                            elevation: 17,
                            shape: RoundedRectangleBorder(
                                //to set border radius to button
                                borderRadius: BorderRadius.circular(55)),
                          ),
                          child: const Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                height: 1.2,
                                fontFamily: "Roboto-Regular",
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 15),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/fourth');
                          },
                        ),
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "FORGOT YOUR PASSWORD?",
                          style: TextStyle(
                              height: 0.8,
                              fontFamily: "SignikaNegative-Regular",
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 12.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment.bottomCenter,
              heightFactor: 0.6,
              child: Text(
                "---------Need a new account?--------",
                style: TextStyle(
                    height: 2,
                    fontFamily: "NotoSans-Regular",
                    fontWeight: FontWeight.w900,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 14.2),
              ),
            ),
            Container(
              height: 25.0,
              width: 143.2,
              margin: const EdgeInsets.all(9),
              padding: const EdgeInsets.all(0.1),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(
                      255, 255, 255, 255), //background color of button
                  side: const BorderSide(
                      width: 2.1,
                      color: Color.fromARGB(
                          255, 0, 0, 0)), //border width and color
                  elevation: 17,
                  shape: RoundedRectangleBorder(
                      //to set border radius to button
                      borderRadius: BorderRadius.circular(55)),
                ),
                child: const Text(
                  "CREATE ACCOUNT",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.4,
                      fontFamily: "NotoSans-Regular",
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 13),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
