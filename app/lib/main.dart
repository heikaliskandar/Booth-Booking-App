import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(const BoothApp());
}

class BoothApp extends StatelessWidget {
  const BoothApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MaterialColor customSwatch = const MaterialColor(0xFF182B5C, {
      50: Color(0xFF182B5C),
      100: Color(0xFF182B5C),
      200: Color(0xFF182B5C),
      300: Color(0xFF182B5C),
      400: Color(0xFF182B5C),
      500: Color(0xFF182B5C),
      600: Color(0xFF182B5C),
      700: Color(0xFF182B5C),
      800: Color(0xFF182B5C),
      900: Color(0xFF182B5C),
    });

    return MaterialApp(
      title: 'PearlyWhites',
      theme: ThemeData(
        primarySwatch: customSwatch,
      ),
      home: const MyHomePage(title: 'PearlyWhites'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
