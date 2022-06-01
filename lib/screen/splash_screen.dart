import 'package:flutter/material.dart';
import 'package:projek_edspert/controller/AuthProviderController.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AuthProviderController>(context, listen: false)
        .directAfterSplashScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff004AAD),
      body: Center(
        child: Image.asset(
          "assets/img/Go-UTBK.png",
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
