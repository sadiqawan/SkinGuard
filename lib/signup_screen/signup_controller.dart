import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_firebase/signup_screen/login_screen.dart';

class SignupScreenController extends GetxController {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  Future<void> signUp() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      // await auth.signInWithEmailAndPassword(
      //     email: emailController.text.trim(),
      //     password: passwordController.text.trim()
      // );
      auth.createUserWithEmailAndPassword(email: emailController.text.trim(),
          password: passwordController.text.trim());

      Get.offAll(const LoginScreen());
    } catch (e) {
      print(e.toString());
    }
  }


}