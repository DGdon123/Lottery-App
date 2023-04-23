import 'dart:convert';

import 'package:ecommerce/NetworkHandler.dart';
import 'package:ecommerce/models/ply.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/accounting.dart';
import '../models/ordermodel.dart';
import '../models/profile.dart';

NetworkHandler networkHandler = NetworkHandler();
Post profileModel = Post();

FlutterSecureStorage storage = FlutterSecureStorage();
gettingData() async {
  var response = await networkHandler.get("user");
  print(response);
  profileModel = Post.fromJson(response);
  print(profileModel);
  String? token = await storage.read(key: "token");
  var res = await http.get(
      Uri.parse(
          'https://trulam.prabidhienterprises.com/api/order/${profileModel.id}'),
      headers: {"Authorization": "Bearer $token"});
  print(res.body);
  if (res.statusCode == 200) {
    Order dum = orderFromJson(res.body);

    if (dum != null) return dum;
  } else {
    throw Exception('Failed to load data');
  }
}
