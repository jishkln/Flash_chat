import 'package:firebase_core/firebase_core.dart';

import 'package:flash_chat/helper/conroller_init.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/phone_auth.dart';
import 'package:flash_chat/screens/phone_verification.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onInit: () => controllerInit(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        LoginScreen.id: (context) => const LoginScreen(),
        RegistrationScreen.id: (context) => const RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PhoneLogin.id: (context) => const PhoneLogin(),
        OtpScreen.id: (context) => const OtpScreen(),
      },
    );
  }
}
