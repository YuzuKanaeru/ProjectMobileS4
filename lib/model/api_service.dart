import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user.dart';

class ApiService {
  final String baseUrl = 'https://sivosis.my.id/api/akun/tampil';

  Future<User?> login(String nisNip, String password) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(response.body);

        for (var user in users) {
          if (user['nis_nip'] == nisNip && user['pass'] == password) {
            return User.fromJson(user);
          }
        }
        print('User not found or incorrect password');
      } else {
        print('Failed to load user data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }
}
