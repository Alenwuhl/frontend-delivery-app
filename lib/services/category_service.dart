import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryService {
  static const baseUrl = 'https://futuristic-delivery-app-9z0i.onrender.com/api/categories/';  

  Future<List<dynamic>> getCategories() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        // Parsing JSON to a list if the response is OK.
        return json.decode(response.body) as List;
      } else {
        throw Exception('Failed to load categories from the server');
      }
    } catch (e) {
      throw Exception('Failed to execute request: $e');
    }
  }
}

