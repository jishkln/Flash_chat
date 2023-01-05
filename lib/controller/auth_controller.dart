import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/home_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
//email,password,name...
  late Rx<User?> _user;
  RxBool isLoading = false.obs;
  var verificationId = "".obs;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScrean);
  }

  _initialScrean(User? user) {
    if (user == null) {
      print("user not loginrd");
      Get.offAll(() => const WelcomeScreen());
    } else {
      Get.offAll(() => HomeScreen(email: user.email.toString()));
    }
  }

  void register(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About User",
        "User Message",
        backgroundColor: Colors.amber,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account creation faild",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
    isLoading.value = false;
    update();
  }

  void login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login Message",
        backgroundColor: Colors.amber,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Account Login faild",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
    isLoading.value = false;
    update();
  }

  void lodinPhone(String phone) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: ((error) {
          if (error.code == "invalid-phone-number") {
            Get.snackbar(
              'error',
              'invalid phone number',
            );
          } else {
            Get.snackbar(
              'error',
              'some thing went ronggggg',
            );
          }
        }),
        codeSent: (verificationId, forceResendingToken) {
          this.verificationId.value = verificationId;
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar(
        "About Login",
        "Login Message",
        backgroundColor: Colors.amber,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          "Phone Login faild",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(
          e.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  Future<bool> otpCheck(String otp) async {
    var data = await auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: verificationId.value, smsCode: otp));

    return data.user != null ? true : false;
  }

  void verifyOtp(String otp) async {
    isLoading.value = true;
    var isVerifie = await otpCheck(otp);
    isVerifie ? Get.offAll(() => HomeScreen()) : Get.back();
    isLoading.value = false;
    update();
  }

  void logOut() async {
    await auth.signOut();
  }
}
