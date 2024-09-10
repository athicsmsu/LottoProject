import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lotto_application/pages/login.dart';
import 'package:lotto_application/shared/app_data.dart';
import 'package:provider/provider.dart';


void main() async {

  await GetStorage.init();
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Appdata(),
      )
    ],
    child: const MyApp(),
  ));

  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lotto App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(onPrimary: Color(0xFF024B3F)),
        useMaterial3: true,
      ),
      home: const LoginPage()
    );
  }
}