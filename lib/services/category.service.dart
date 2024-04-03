import 'package:http/http.dart' as http;
import 'dart:convert';

//Get all categories
class CategoryService {
  static const String baseUrl = 'http://localhost:3000/api/categories';

  Future<List> getCategories() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories from the server');
    }
  }
}
