import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MaterialApp(home: NetlifyTest()));

class NetlifyTest extends StatefulWidget {
  const NetlifyTest({super.key});

  @override
  State<NetlifyTest> createState() => _NetlifyTestState();
}

class _NetlifyTestState extends State<NetlifyTest> {
  String _message = "Press the button to test API";

  Future<void> _callApi() async {
    try {
      // Relative path works because of netlify.toml redirects
      final response = await http.get(Uri.parse('/api/hello'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() => _message = data['message']);
      } else {
        setState(() => _message = "Error: ${response.statusCode}");
      }
    } catch (e) {
      setState(() => _message = "Connection failed: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Netlify + FastAPI")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _callApi, child: const Text("Test API")),
          ],
        ),
      ),
    );
  }
}