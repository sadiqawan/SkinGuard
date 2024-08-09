import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_firebase/ui/auth/login_view/login_view.dart';

class ProfileViewController extends GetxController {
  File? image;
  String imageUrl = '';

  // Stream to get user data
  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDataStream() {
    String uId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance.collection('users').doc(uId).snapshots();
  }

  // Function to pick an image from the source and upload it
  Future<void> pickImageFrom(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        image = File(pickedFile.path);
        if (image != null) {
          final storageRef = FirebaseStorage.instance
              .ref('user_images')
              .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');
          await storageRef.putFile(image!);
          imageUrl = await storageRef.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({'picture': imageUrl});

          Get.snackbar("Success", "Image updated successfully",
              snackPosition: SnackPosition.TOP, backgroundColor: Colors.green);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Error: $e',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      print("Error picking image: $e");
    }
  }








  Future<void> logout() async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signOut();
      Get.offAll(const LoginScreen());
      Get.snackbar(
        "Success",
        'Successfully logout!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(.3),
      );
    } catch (e) {
      Get.snackbar(
        "Failed",
        'Failed!${e.toString()}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withOpacity(.3),
      );
    }
  }
}
