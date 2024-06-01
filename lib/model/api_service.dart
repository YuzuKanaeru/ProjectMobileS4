import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class ApiService {
  final String baseUrl = 'https://vote.sipkopi.com/api/akun/tampil/';

  Future<User?> login(String nisNip, String password) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl$nisNip'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> userMap = jsonDecode(response.body);

        
        if (userMap['pass'] == password) {
          return User.fromJson(userMap);
        } else {
          print('Password does not match');
        }
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }
}
