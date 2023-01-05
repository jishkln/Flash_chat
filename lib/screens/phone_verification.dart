import 'package:flash_chat/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  static const String id = "Otp_screen";

  @override
  Widget build(BuildContext context) {
    var otp;
    final pinputController = TextEditingController();
    final focusNode = FocusNode();
    final formKey = GlobalKey<FormState>();

    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    return Scaffold(
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
                "fndn amat vhandh us a vr=ey oiitnan ahd he 8is a bvad gay "),
            Center(
              child: Pinput(
                animationCurve: Curves.easeInCirc,
                length: 6,
                controller: pinputController,
                focusNode: focusNode,
                // androidSmsAutofillMethod:
                //     AndroidSmsAutofillMethod.smsUserConsentApi,
                listenForMultipleSmsOnAndroid: true,
                defaultPinTheme: defaultPinTheme,
                validator: (value) {
                  return value == '2222' ? null : 'Pin is incorrect';
                },
                // onClipboardFound: (value) {
                //   debugPrint('onClipboardFound: $value');
                //   pinController.setText(value);
                // },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                onCompleted: (pin) {
                  debugPrint('onCompleted: $pin');
                  otp = pin;
                  AuthController.instance.verifyOtp(otp);
                },
                onChanged: (value) {
                  debugPrint('onChanged: $value');
                },
                cursor: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 9),
                      width: 22,
                      height: 1,
                      color: focusedBorderColor,
                    ),
                  ],
                ),
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    color: fillColor,
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: Colors.redAccent),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                formKey.currentState!.validate();
                AuthController.instance.verifyOtp(otp);
              },
              child: const Text('Validate'),
            ),
          ],
        ),
      ),
    );
  }
}
