import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/models/cart_model.dart';


class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItemsList = [];

  List<CartItem> get cartItemsList => _cartItemsList;

  void addCartItem(CartItem cartItem) {
    _cartItemsList.add(cartItem);
    notifyListeners();
  }

  void addAndReturnToPreviousPage(BuildContext context, CartItem cartItem) {
    addCartItem(cartItem);
    Navigator.pop(context);
  }

  void removeCartItem(int cartItemId) {
    _cartItemsList.removeWhere((cartItem) => cartItem.cartItemId == cartItemId);
    notifyListeners();
  }
}
