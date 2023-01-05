import 'package:flash_chat/controller/auth_controller.dart';
import 'package:flash_chat/screens/phone_verification.dart';
import 'package:flash_chat/screens/widgets/coustom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class PhoneLogin extends StatelessWidget {
  const PhoneLogin({super.key});
  static const String id = "Phone_screen";

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
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
                keyboardType: TextInputType.number,
                controller: phoneController,
                onChanged: (value) {
                  //Do something with the user input.
                },
                decoration:
                    KInputDecoration.copyWith(hintText: 'Enter your password')),
            const SizedBox(
              height: 24.0,
            ),
            CoustomButton(
                btnName: 'Verify',
                onPressed: () {
                  AuthController.instance
                      .lodinPhone('+91${phoneController.text.trim()}');
                  Get.off(() => const OtpScreen());
                },
                btnColor: Colors.lightBlueAccent),
          ],
        ),
      ),
    );
  }
}
