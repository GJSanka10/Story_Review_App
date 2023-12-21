import 'package:http/http.dart' as http;
import 'dart:convert';

class Api {
  static const String baseUrl =
      "http://app360dev-001-site17.atempurl.com/api/Interview";

  static const String signInEndpoint = "/SignIn";

  static Future<Map<String, dynamic>> signIn(
      String email, String password) async {
    final Uri uri = Uri.parse('$baseUrl$signInEndpoint');

    try {
      final response = await http.post(
        uri,
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Successful login
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        // Handle other status codes
        print("Login failed. Status code: ${response.statusCode}");
        return {'error': 'Login failed'};
      }
    } catch (e) {
      // Handle network or server errors
      print("Error during login: $e");
      return {'error': 'Error during login'};
    }
  }
}
