import 'package:flutter/material.dart';
import 'view/MainScreen.dart';
import 'view/SplashScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/splash': (_) => SplashScreen(),
        '/main': (_) => MainScreen(),
      },
      initialRoute: '/splash',
    );
  }
}