import 'package:flutter/material.dart';
import 'package:projek_edspert/screen/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Login',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Image.asset("assets/img/Analysis _Isometric.png")),
              const Text(
                'Selamat Datang',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'Selamat Datang di Aplikasi Widya Edu Aplikasi Latihan dan Konsultasi Soal',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white,
                      fixedSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: const BorderSide(
                              color: Colors.blue,
                              style: BorderStyle.solid,
                              width: 1)),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => const RegisterPage()),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Image.asset("assets/img/icons8-google-48.png"),
                        ),
                        const Text(
                          'Masuk dengan Google',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.black,
                      fixedSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Image.asset("assets/img/auth/ic_apple.png"),
                        ),
                        const Text(
                          'Masuk dengan Apple',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 40.0)
            ],
          ),
        ),
      ),
    );
  }
}
