import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 58, 127, 213),
      body: Center(child: Image(image: AssetImage("assets/img/Logo.png"))),
    );
  }
}
