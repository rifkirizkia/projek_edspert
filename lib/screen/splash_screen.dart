import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projek_edspert/controller/AuthProviderController.dart';
import 'package:projek_edspert/screen/login_page.dart';
import 'package:projek_edspert/screen/main_page.dart';
import 'package:projek_edspert/screen/register_page.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  // @override
  // void initState() {
  //   //life cycle flutter
  //   super.initState();
  //   goToNextPage();
  // }

  @override
  Widget build(BuildContext context) {
    Provider.of<AuthProviderController>(context, listen: false)
        .directAfterSplashScreen(context);

    return Scaffold(
      backgroundColor: Color(0xff3A7FD5),
      body: Center(
        child: Image.asset(
          "assets/img/auth/ic_splash.png",
          width: MediaQuery.of(context).size.width * 0.45,
        ),
      ),
    );
  }
}
