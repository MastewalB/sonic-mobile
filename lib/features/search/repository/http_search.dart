import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchDataProvider {
  static const String _baseUrl =
      'http://192.168.200.116:8000/api/v1'; // Replace with your API base URL

  Future<List<dynamic>> search(String query) async {
    print(query);
    final url =
        Uri.parse('$_baseUrl/search/?search_query=$query&search_type=all');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> results = jsonDecode(response.body);
        final Map<String, List<dynamic>> groupedResults = {
          'song': [],
          'album': [],
          'artist': [],
        };

        for (final result in results) {
          final type = result['type'];
          if (groupedResults.containsKey(type)) {
            groupedResults[type]!.add(result);
          }
        }

        final List<List<dynamic>> updatedResponse =
            groupedResults.values.toList();
        // print(updatedResponse[2]);
        return updatedResponse;
      } else {
        throw Exception('Failed to fetch search results');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
