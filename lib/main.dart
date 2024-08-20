import 'package:flutter/material.dart';
import 'package:lotto_application/pages/admin/adward.dart';
import 'package:lotto_application/pages/admin/main.dart';
import 'package:lotto_application/pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(onPrimary: Color(0xFF024B3F)),
        useMaterial3: true,
      ),
      home: LoginPage()
    );
  }
}
