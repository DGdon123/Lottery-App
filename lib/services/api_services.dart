import 'dart:convert';

import 'package:ecommerce/models/ply.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

var link = 'https://trulam.prabidhienterprises.com/api/products';
FlutterSecureStorage storage = FlutterSecureStorage();
Future<Ply?> getData() async {
  String? token = await storage.read(key: "token");
  var res = await http
      .get(Uri.parse(link), headers: {"Authorization": "Bearer $token"});
  print(res.body);
  if (res.statusCode == 200) {
    Ply? dum = plyFromJson(res.body);
    print(dum);
    if (dum != null) return dum;
  } else {
    throw Exception('Failed to load data');
  }
}
