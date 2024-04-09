import 'package:http/http.dart' as http;
import 'dart:convert';

//Get all products for a specific category
class ExtrasService {
  // Base de la URL, sin incluir el path específico de la categoría
  static const String baseApiUrl = '192.168.68.105:3000';
  static const String baseApiPath = '/api/products';

  // Función para obtener productos por categoría
  Future<List<dynamic>> getExtrasProduct(String productId) async {
    var url = Uri.http(baseApiUrl, '$baseApiPath/$productId/extras');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      // We expect jsonResponse to be a Map with a key "extras"
      if (jsonResponse is Map<String, dynamic> && jsonResponse.containsKey('extras')) {
        return jsonResponse['extras'];
      } else {
        throw Exception('The response does not contain the "extras" key');
      }
    } else {
      throw Exception('Failed to load extras for product $productId from the server');
    }
  }
}
