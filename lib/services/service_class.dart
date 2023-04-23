import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:ecommerce/models/cartmodel.dart';
import 'package:http/http.dart' as http;

Future<http.Response?> register(Cart data) async {
  http.Response? response;
  try {
    response = await http.post(
        Uri.parse("https://trulam.prabidhienterprises.com/api/cart/store"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(data.toJson()));
  } catch (e) {
    log(e.toString());
  }
  return response;
}
