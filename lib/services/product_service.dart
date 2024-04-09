import 'package:http/http.dart' as http;
import 'dart:convert';

//Get all products for a specific category
class ProductService {
  // Base de la URL, sin incluir el path específico de la categoría
  static const String baseApiUrl = '192.168.68.105:3000';
  static const String baseApiPath = '/api/products';

  // Función para obtener productos por categoría
  Future<List<dynamic>> getProductsByCategory(String categoryId) async {
    // Construye la URL completa con el catId dinámico
    var url = Uri.http(baseApiUrl, '$baseApiPath/$categoryId/category');

    // Hace la solicitud GET
    var response = await http.get(url);

    // Verifica el estado de la respuesta
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products for category $categoryId from the server');
    }
  }
}
