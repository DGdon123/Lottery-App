import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

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
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  height: 862.88,
                  width: 500.0,
                  child: Container(
                    child: Column(
                      children: [
                        Align(
                          heightFactor: 1.4,
                          alignment: Alignment.bottomCenter,
                          child: Image.asset(
                            "images/logo.png",
                            width: 160,
                            height: 115,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          height: 598,
                          width: 257.0,
                          margin: const EdgeInsets.all(16),
                          padding: const EdgeInsets.all(0.1),
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFd81921),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(13.0)),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  width: 2,
                                  style: BorderStyle.solid),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  "Create a New Account",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      height: 2.25,
                                      fontFamily: "SignikaNegative-Bold",
                                      fontWeight: FontWeight.w900,
                                      color: Color(0xFFD7F9F1),
                                      fontSize: 19),
                                ),
                                Column(
                                  children: [
                                    const Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Full Name",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 2.1,
                                            fontFamily: "Roboto-Regular",
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 16),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: 37.0,
                                        width: 208.0,
                                        margin: const EdgeInsets.all(0.1),
                                        padding: const EdgeInsets.all(0.1),
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                          border: Border.all(
                                              color: const Color(0xFF5C573E),
                                              width: 1.6,
                                              style: BorderStyle.solid),
                                        ),
                                        child: const TextField(
                                          decoration: InputDecoration(
                                            labelText: 'Enter your fullname',
                                            labelStyle: TextStyle(
                                                height: 4,
                                                fontFamily:
                                                    "SignikaNegative-Regular",
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 16),
                                            contentPadding: EdgeInsets.all(8),
                                            border: OutlineInputBorder(),
                                          ),
                                          style: TextStyle(fontSize: 14),
                                          maxLines: 1,
                                          minLines: 1,
                                        ),
                                      ),
                                    ),
                                    const Text(
                                      "Email",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 2.0,
                                          fontFamily: "Roboto-Regular",
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 37.0,
                                      width: 208.0,
                                      margin: const EdgeInsets.all(0.1),
                                      padding: const EdgeInsets.all(0.1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                        border: Border.all(
                                            color: const Color(0xFF5C573E),
                                            width: 1.6,
                                            style: BorderStyle.solid),
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Enter your email',
                                          labelStyle: TextStyle(
                                              height: 4,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                                          height: 2.0,
                                          fontFamily: "Roboto-Regular",
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 37.0,
                                      width: 208.0,
                                      margin: const EdgeInsets.all(0.1),
                                      padding: const EdgeInsets.all(0.1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
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
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                                      "Gender",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 2.0,
                                          fontFamily: "Roboto-Regular",
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 37.0,
                                      width: 208.0,
                                      margin: const EdgeInsets.all(0.1),
                                      padding: const EdgeInsets.all(0.1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                        border: Border.all(
                                            color: const Color(0xFF5C573E),
                                            width: 1.6,
                                            style: BorderStyle.solid),
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          labelText:
                                              'Enter Male, Female or Others',
                                          labelStyle: TextStyle(
                                              height: 4,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14),
                                          contentPadding: EdgeInsets.all(8),
                                          border: OutlineInputBorder(),
                                        ),
                                        style: TextStyle(fontSize: 14),
                                        maxLines: 1,
                                        minLines: 1,
                                      ),
                                    ),
                                    const Text(
                                      "Location",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 2.0,
                                          fontFamily: "Roboto-Regular",
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 37.0,
                                      width: 208.0,
                                      margin: const EdgeInsets.all(0.1),
                                      padding: const EdgeInsets.all(0.1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                        border: Border.all(
                                            color: const Color(0xFF5C573E),
                                            width: 1.6,
                                            style: BorderStyle.solid),
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Enter your location',
                                          labelStyle: TextStyle(
                                              height: 4,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
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
                                      "Date of Birth",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 2.0,
                                          fontFamily: "Roboto-Regular",
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 37.0,
                                      width: 105.0,
                                      margin: const EdgeInsets.all(0.1),
                                      padding: const EdgeInsets.all(0.1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                        border: Border.all(
                                            color: const Color(0xFF5C573E),
                                            width: 1.6,
                                            style: BorderStyle.solid),
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          labelText: 'MM/DD/YYYY',
                                          labelStyle: TextStyle(
                                              height: 4,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 13.45),
                                          contentPadding: EdgeInsets.all(8),
                                          border: OutlineInputBorder(),
                                        ),
                                        style: TextStyle(fontSize: 14),
                                        maxLines: 1,
                                        minLines: 1,
                                      ),
                                    ),
                                    const Text(
                                      "Age",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          height: 2.0,
                                          fontFamily: "Roboto-Regular",
                                          fontWeight: FontWeight.w500,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 16),
                                    ),
                                    Container(
                                      height: 37.0,
                                      width: 105.0,
                                      margin: const EdgeInsets.all(0.1),
                                      padding: const EdgeInsets.all(0.1),
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0)),
                                        border: Border.all(
                                            color: const Color(0xFF5C573E),
                                            width: 1.6,
                                            style: BorderStyle.solid),
                                      ),
                                      child: const TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Enter your age',
                                          labelStyle: TextStyle(
                                              height: 4,
                                              fontFamily:
                                                  "SignikaNegative-Regular",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 13.20),
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
                                      width: 88.3,
                                      margin: const EdgeInsets.all(19),
                                      padding: const EdgeInsets.all(0.1),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255), //background color of button
                                          side: const BorderSide(
                                              width: 2.1,
                                              color: Color.fromARGB(255, 0, 0,
                                                  0)), //border width and color
                                          elevation: 17,
                                          shape: RoundedRectangleBorder(
                                              //to set border radius to button
                                              borderRadius:
                                                  BorderRadius.circular(55)),
                                        ),
                                        child: const Text(
                                          "Register",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 1.2,
                                              fontFamily: "Roboto-Regular",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 15),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/third');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.center,
                          heightFactor: 0.2,
                          child: Text(
                            "-------Already have a account?------",
                            style: TextStyle(
                                height: 2.0,
                                fontFamily: "NotoSans-Regular",
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 14.2),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          heightFactor: 2.63,
                          child: Container(
                            height: 25.0,
                            width: 75,
                            margin: const EdgeInsets.all(0.1),
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
                                "LOGIN",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.4,
                                    fontFamily: "NotoSans-Regular",
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 13),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/third');
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
