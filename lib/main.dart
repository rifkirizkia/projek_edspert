import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projek_edspert/screen/home_page.dart';
import 'package:projek_edspert/screen/main_page.dart';
import 'package:projek_edspert/screen/register_page.dart';
import 'package:projek_edspert/screen/splash_screen.dart';

void main() {
  // await FireBase.initializeApp();
  // SystemChrome.setPreferredOrientations
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: RegisterPage());
  }
}
