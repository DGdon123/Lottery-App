import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartModel with ChangeNotifier {
  CartModel() {
    _loadCount();
  }
  int? _cartCount = 0;

  int? get cartCount => _cartCount;

  void updateCartCount(int value) async {
    _cartCount = value;
    notifyListeners();
    _saveCount();
  }

  void _loadCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = prefs.getInt('cartCount') ?? 0;
    updateCartCount(count);
  }

  void _saveCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cartCount', _cartCount!);
  }
}
