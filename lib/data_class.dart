import 'package:ecommerce/models/cartmodel.dart';
import 'package:ecommerce/services/service_class.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DataClass extends ChangeNotifier {
  bool loading = false;
  bool isBack = false;
  Future<void> postData(Cart body) async {
    loading = true;
    notifyListeners();
    http.Response response = (await register(body))!;
    if (response.statusCode == 200) {
      isBack = true;
    }
    loading = false;
    notifyListeners();
  }
}
