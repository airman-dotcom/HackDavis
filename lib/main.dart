import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<String> callFastAPI() async {
    // Note: Use the relative path defined in netlify.toml redirects
    final response = await http.get(Uri.parse('/api/hello'));
    
    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      return 'Failed to connect to FastAPI';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Flutter + FastAPI')),
        body: Center(
          child: FutureBuilder<String>(
            future: callFastAPI(),
            builder: (context, snapshot) {
              if (snapshot.hasData) return Text(snapshot.data!);
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}