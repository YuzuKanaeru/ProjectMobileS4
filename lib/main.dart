import 'package:flutter/material.dart';
import 'package:flutter_app/pages/dashboard.dart';
import 'package:flutter_app/pages/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Si Vosis',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}
