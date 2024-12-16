import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
    return Scaffold(
      body: Center(
        child: Text('로고 또는 로딩 화면'),
      ),
    );
  }
}