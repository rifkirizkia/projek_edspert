import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projek_edspert/controller/AuthProviderController.dart';
import 'package:projek_edspert/screen/login_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthProviderController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Provider.of<AuthProviderController>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("Profile"),
            ElevatedButton(
                onPressed: () {
                  controller.signOut(context);
                },
                child: const Text('SignOut'))
          ],
        ),
      ),
    );
  }
}
