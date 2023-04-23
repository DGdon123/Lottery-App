import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class NetworkHandler {
  String baseurl = "https://trulam.prabidhienterprises.com/api/";
  var log = Logger();
  FlutterSecureStorage storage = FlutterSecureStorage();
  Future get(String url) async {
    if (url == null) {
      log.e("Error: url is null");
      return null;
    }
    try {
      String? token = await storage.read(key: "token");
      url = formater(url);
      var response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Bearer $token"},
      );
      if (response.statusCode == 200) {
        log.i(response.body);
        return json.decode(response.body);
      }
      log.i(response.body);
      log.i(response.statusCode);
    } on Exception catch (e) {
      log.e("Error: $e");
      return null;
    }
  }

  String formater(String url) {
    return baseurl + url;
  }
}
