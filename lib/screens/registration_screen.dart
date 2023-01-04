import 'dart:developer';

import 'package:flash_chat/constants.dart';
import 'package:flash_chat/controller/auth_controller.dart';
import 'package:flash_chat/screens/widgets/coustom_btn.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});
  static const String id = "Register_Screem";

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: "logo",
              child: SizedBox(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration:
                    KInputDecoration.copyWith(hintText: 'Enter your email')),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
                obscureText: true,
                controller: passwordController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration:
                    KInputDecoration.copyWith(hintText: 'Enter your password')),
            const SizedBox(
              height: 24.0,
            ),
            CoustomButton(
                btnName: 'Register',
                onPressed: () {
                  AuthController.instance.register(emailController.text.trim(),
                      passwordController.text.trim());
                },
                btnColor: Colors.blueAccent)
          ],
        ),
      ),
    );
  }
}
