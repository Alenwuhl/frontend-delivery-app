import 'package:flutter/material.dart';
import 'package:frontend_delivery_app/models/cart_model.dart';
import 'package:collection/collection.dart';

// Provider for the cart
class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItemsList = [];

  List<CartItem> get cartItemsList => _cartItemsList;

//Add something to the cart 
  void addCartItem(CartItem cartItem) {
    var existingItemIndex = _cartItemsList.indexWhere(
      (item) =>
        item.productId == cartItem.productId &&
        _listEquality(item.selectedExtras, cartItem.selectedExtras),
    );

    if (existingItemIndex != -1) {
      _cartItemsList[existingItemIndex].quantity++;
    } else {
      _cartItemsList.add(cartItem);
    }
    notifyListeners();
  }

// Remove something for the cart
  void removeCartItem(int cartItemId) {
    _cartItemsList.removeWhere((cartItem) => cartItem.cartItemId == cartItemId);
    notifyListeners();
  }

// To change the quantity
  void modifyCartItemQuantity(int cartItemId, int change) {
    var cartItemIndex = _cartItemsList.indexWhere((item) => item.cartItemId == cartItemId);
    if (cartItemIndex != -1) {
      var cartItem = _cartItemsList[cartItemIndex];
      
      cartItem.quantity += change;
      if (cartItem.quantity < 1) {
        cartItem.quantity = 1;
      }
      cartItem.updatePrice();
      notifyListeners();
    }
  }

  bool _listEquality(List<String> list1, List<String> list2) {
    var sortedList1 = List<String>.from(list1)..sort();
    var sortedList2 = List<String>.from(list2)..sort();
    return const ListEquality().equals(sortedList1, sortedList2);
  }

// Add product to the cart ando continue shopping
  void addAndReturnToPreviousPage(BuildContext context, CartItem cartItem) {
    addCartItem(cartItem);
    Navigator.pop(context);
  }

//calculate the final cart amount
    double get totalAmount {
    return _cartItemsList.fold(0.0, (total, current) => total + current.cartItemPrice);
  }

//After the purchase - clear the cart
    void clearCart() {
    _cartItemsList.clear(); 
    notifyListeners(); 
  }
}
