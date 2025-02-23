import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // ✅ Ensure HomeScreen is imported

void main() {
  runApp(const MyApp()); // ✅ This should be defined
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sinhala to English Translator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(), // ✅ Ensure `HomeScreen` exists
    );
  }
}
