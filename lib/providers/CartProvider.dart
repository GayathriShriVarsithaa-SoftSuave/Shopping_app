import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> cart = [];

  void addProduct(Map<String, dynamic> product, String selectedSize) {
  final cartProduct = {
    ...product,
    'selectedSize': selectedSize,
  };

  cart.add(cartProduct);
  notifyListeners();
}
  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }
}
