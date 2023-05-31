import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchDataProvider {
  static const String _baseUrl =
      'http://localhost:8000/api/v1/'; // Replace with your API base URL

  Future<List<dynamic>> search(String query) async {
    final url = Uri.parse('$_baseUrl/search?query=$query');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        return results;
      } else {
        throw Exception('Failed to fetch search results');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
