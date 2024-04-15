import 'package:frontend_delivery_app/models/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
const baseUrl = 'https://futuristic-delivery-app-9z0i.onrender.com/api/orders';

class OrderService {
  Future<http.Response> createOrder(List<CartItem> cartItems, double totalAmount) async {
    final prefs = await SharedPreferences.getInstance();

    // Here we must recover the signin data
    String? userId = prefs.getString('user_id');
    String? email = prefs.getString('user_email');
    String? token = prefs.getString('auth_token'); 
    
    if (userId == null || email == null || token == null) {
      throw Exception('It is not possible to make a purchase without logging in.');
    }
    
    var orderItems = cartItems.map((item) {
      return {
        'productId': item.productId,
        'quantity': item.quantity,
        'extrasIds': item.selectedExtras,
      };
    }).toList();
    
    var body = json.encode({
      'userId': userId,
      'email': email,
      'totalAmount': totalAmount,
      'orderItems': orderItems,
    });
    
    var response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', 
      },
      body: body,
    );

    return response;
  }
}
