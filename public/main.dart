import 'package:flutter/material.dart';
import 'api_service.dart';

final response = await http.get(Uri.parse('/'));

void main() => runApp(const MaterialApp(home: AuthPage()));

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final ApiService _api = ApiService();

  void _showMsg(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mongo Auth")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: "Username")),
            TextField(controller: _passController, decoration: const InputDecoration(labelText: "Password"), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                var res = await _api.login(_userController.text, _passController.text);
                _showMsg(res['status'] == 'success' ? "Logged in as ${res['username']}" : res['detail']);
              }, 
              child: const Text("Login")
            ),
            TextButton(
              onPressed: () async {
                var res = await _api.signup(_userController.text, "${_userController.text}@mail.com", _passController.text);
                _showMsg(res['message'] ?? res['detail']);
              }, 
              child: const Text("Create Account")
            ),
          ],
        ),
      ),
    );
  }
}
//hi

