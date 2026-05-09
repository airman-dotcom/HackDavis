import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS simulator
  static const String baseUrl = "http://10.0.2.2:8000";

  Future<Map<String, dynamic>> signup(String user, String email, String pass) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": user, "email": email, "password": pass}),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> login(String user, String pass) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"username": user, "password": pass}),
    );
    return jsonDecode(response.body);
  }
}
//hi