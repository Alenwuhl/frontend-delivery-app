
import 'package:http/http.dart' as http;
import 'dart:convert';

//Get all products for a specific category
class ExtrasService {

  //getExtrasProduct brings the extras associated with each product
  Future<List<dynamic>> getExtrasProduct(String productId) async {
    String baseUrl = 'https://futuristic-delivery-app-9z0i.onrender.com/api/products/$productId/extras'; 
    
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);

      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse.containsKey('extras')) {
        return jsonResponse['extras'];
      } else {
        throw Exception('The response does not contain the "extras" key');
      }
    } else {
      throw Exception(
          'Failed to load extras for product $productId from the server');
    }
  }
}
