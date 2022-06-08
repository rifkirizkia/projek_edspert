import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projek_edspert/controller/AuthProviderController.dart';
import 'package:projek_edspert/screen/discussion_page.dart';
import 'package:projek_edspert/screen/home_page.dart';
import 'package:projek_edspert/screen/main_page.dart';
import 'package:projek_edspert/screen/register_page.dart';
import 'package:projek_edspert/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
          title: 'Go UTBK',
          routes: {'/discussion_page': (_) => DiscussionPage()},
          theme: ThemeData(
              appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 58, 127, 213),
          )),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen()),
    );
  }
}
