import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: Image.asset("assets/img/Analysis _Isometric.png")),
          const Text(
            'Selamat Datang',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const Text(
            'Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal',
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
