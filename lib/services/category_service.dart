import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryService {
  // Make sure your base URL ends with a '/' or adjust the endpoint concatenation accordingly.
  static const baseUrl = 'https://futuristic-delivery-app-9z0i.onrender.com/api/categories/';  // '${dotenv.env['HOST']}/api/categories/';

  // Using a nullable return type is fine, but it could be more helpful to return an empty list in case of failure.
  Future<List<dynamic>> getCategories() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        // Parsing JSON to a list if the response is OK.
        return json.decode(response.body) as List;
      } else {
        // Logging or handling different status codes might be useful.
        print('Request failed with status: ${response.statusCode}.');
        throw Exception('Failed to load categories from the server');
      }
    } catch (e) {
      // Catching any other errors that might occur during the HTTP request.
      print('An error occurred: $e');
      throw Exception('Failed to execute request: $e');
    }
  }
}

