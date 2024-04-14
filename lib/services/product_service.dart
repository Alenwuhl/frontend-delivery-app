import 'package:http/http.dart' as http;
import 'dart:convert';

//Get all products for a specific category
class ProductService {

  Future<List<dynamic>>? getProductsByCategory(String categoryId) async {
     String baseUrl = 'https://futuristic-delivery-app-9z0i.onrender.com/api/products/$categoryId/category'; 

    var response = await http.get(Uri.parse(baseUrl));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load products for category $categoryId from the server');
    }
  }
}
