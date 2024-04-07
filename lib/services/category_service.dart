import 'package:http/http.dart' as http;
import 'dart:convert';

//Get all categories
class CategoryService {
  static const String baseUrl = 'http://192.168.68.108:3000/api/categories';

  Future<List<dynamic>>? getCategories() async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories from the server');
    }
  }
}
