import 'package:frontend_delivery_app/models/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  Future<http.Response> createOrder(List<CartItem> cartItems, double totalAmount) async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    String? email = prefs.getString('user_email');
    String? token = prefs.getString('auth_token'); // Recuperar el token.

    print(email);
    print(userId);
    print(token);
    
    if (userId == null || email == null || token == null) {
      throw Exception('No user ID, email, or token found in SharedPreferences');
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
      Uri.parse('http://192.168.68.105:3000/api/orders'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token', // Incluir el token en los headers.
      },
      body: body,
    );

    print('body -' + body);

    return response;
  }
}
