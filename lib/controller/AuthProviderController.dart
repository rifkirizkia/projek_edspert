import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projek_edspert/models/data_by_user_email.dart';
import 'package:projek_edspert/models/matapelajaran_list.dart';
import 'package:projek_edspert/repository/auth_api.dart';
import 'package:projek_edspert/repository/latihan_soal_api.dart';

import '../screen/login_page.dart';
import '../screen/main_page.dart';
import '../screen/register_page.dart';

class AuthProviderController extends ChangeNotifier {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  directAfterSplashScreen(context) {
    Timer(const Duration(seconds: 2), () async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final response =
            await AuthApi().getUserByEmail("alitopan@widyaedu.com");
        if (response != null) {
          print(response);
          final userData = DataUserByEmail.fromJson(response);
          if (userData.status == 1) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => MainPage()),
              ),
            );
          } else {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: ((context) => RegisterPage()),
              ),
            );
          }
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => LoginPage()),
            ),
          );
        }
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: ((context) => LoginPage()),
          ),
        );
      }
    });
  }

  signIn(context) async {
    await signInWithGoogle();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user.email);
      final response = await AuthApi().getUserByEmail("alitopan@widyaedu.com");
      print(response);
      if (response != null) {
        print(response);
        final userData = DataUserByEmail.fromJson(response);
        if (userData.status == 1) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => MainPage()),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => RegisterPage()),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Terjadi kesalahan saat pengambilan data user')));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Gagal Masuk')));
    }
  }

  signOut(context) async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: ((context) => LoginPage()),
      ),
    );
  }
}
