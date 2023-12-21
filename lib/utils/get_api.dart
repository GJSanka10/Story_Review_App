// story_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class StoryService {
  Future<List<Map<String, dynamic>>> fetchStories(String userId) async {
    final String apiUrl =
        "http://app360dev-001-site17.atempurl.com/api/Interview/Stories?userId=$userId";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final List<dynamic> content = responseData['content'];
        return List<Map<String, dynamic>>.from(content);
      } else {
        print("Failed to load stories. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error during fetching stories: $e");
      return [];
    }
  }
}
