import 'package:flutter/material.dart';
import 'send_money_page.dart'; // Import the Send Money page
import 'login_page.dart'; // Import the Login page

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.grey[100], // Consistent background
      ),
      home: const LoginPage(), // Set LoginPage as the home page
    );
  }
}
