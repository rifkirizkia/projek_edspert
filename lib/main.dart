import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projek_edspert/controller/AuthProviderController.dart';
import 'package:projek_edspert/screen/home_page.dart';
import 'package:projek_edspert/screen/main_page.dart';
import 'package:projek_edspert/screen/register_page.dart';
import 'package:projek_edspert/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthProviderController(),
      child: MaterialApp(
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 58, 127, 213),
          )),
          debugShowCheckedModeBanner: false,
          home: SplashScreen()),
    );
  }
}
