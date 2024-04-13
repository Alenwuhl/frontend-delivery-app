import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Get all products for a specific category
class ProductService {
  
  //static String? baseApiUrl = dotenv.env['HOST'];
  //static const String baseApiPath = '/api/products';

  Future<List<dynamic>>? getProductsByCategory(String categoryId) async {
     String baseUrl = '${dotenv.env['HOST']}/api/products/$categoryId/category';
    //var url = Uri.http(dotenv.env['HOST']!, '$baseApiPath/$categoryId/category');

    var response = await http.get(Uri.parse(baseUrl));
    print('baseUrl' + baseUrl);
    print(response);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load products for category $categoryId from the server');
    }
  }
}
