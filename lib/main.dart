import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './pages/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Login', home: HomePage());
  }
}
