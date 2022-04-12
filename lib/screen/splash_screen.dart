import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projek_edspert/screen/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  goToNextPage() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) => const LoginPage()),
        ),
      );
    });
  }

  @override
  void initState() {
    //life cycle flutter
    super.initState();
    goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3A7FD5),
      body: GestureDetector(
          onTap: () {
            goToNextPage();
          },
          child: Center(
            child: Image.asset(
              "assets/img/auth/ic_splash.png",
              width: MediaQuery.of(context).size.width * 0.45,
            ),
          )),
    );
  }
}
