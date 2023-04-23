import 'dart:convert';

import 'package:ecommerce/NetworkHandler.dart';
import 'package:ecommerce/models/ply.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/accounting.dart';
import '../models/ordermodel.dart';
import '../models/pay.dart';
import '../models/profile.dart';

NetworkHandler networkHandler = NetworkHandler();
Post profileModel = Post();

FlutterSecureStorage storage = FlutterSecureStorage();
ming() async {
  var response = await networkHandler.get("user");
  print(response);
  profileModel = Post.fromJson(response);
  print(profileModel);
  String? token = await storage.read(key: "token");
  var res = await http.get(
      Uri.parse(
          'https://trulam.prabidhienterprises.com/api/user/${profileModel.id}/payment'),
      headers: {"Authorization": "Bearer $token"});
  print(res.body);
  if (res.statusCode == 200) {
    Payment tree = paymentFromJson(res.body);

    if (tree != null) return tree;
  } else {
    throw Exception('Failed to load data');
  }
}
