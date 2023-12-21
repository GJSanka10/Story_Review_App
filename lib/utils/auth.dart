import 'package:flutter/material.dart';
import 'package:story_app/Screens/user_story_list.dart';
import 'package:story_app/utils/api.dart';


class AuthService {
  Future<void> signIn(BuildContext context, String email, String password) async {
    final Map<String, dynamic> response = await Api.signIn(email, password);

    if (response.containsKey('error')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response['error']),
        ),
      );
    } else {
      if (response['content'] != null && response['content']['id'] != null) {
        String firstName = response['content']['firstName'] ?? '';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Story(userId: response['content']['id'].toString(), firstName: firstName),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User is Not Registerd.'),
          ),
        );
      }
    }
  }
}
