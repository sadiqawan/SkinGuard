import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class ImageProcessController extends GetxController {
  final ScreenshotController screenshotController = ScreenshotController();
  File? file;
  List<String> classNames = [
    'Eczema',
    'Melanoma',
    'Atopic Dermatitis',
    'Basal Cell Carcinoma (BCC)',
    'Melanocytic Nevi (NV)',
    'Benign Keratosis-like Lesions (BKL)',
    'Psoriasis pictures Lichen Planus and related disea',
    'Seborrheic Keratoses and other Benign Tumors',
    'Tinea Ringworm Candidiasis and other Fungal Infect',
    'Normal Skin',
    'Warts Molluscum and other Viral Infections',
  ];



  /// Download receipt
  Future<void> downloadResultImg() async {
    try {
      final capturedImage = await screenshotController.capture();
      if (capturedImage != null) {
        final result = await ImageGallerySaver.saveImage(
          capturedImage,
          quality: 100,
          name: 'Result',
        );

        if (result['isSuccess']) {
          Get.snackbar(
            'Success',
            'Result saved to gallery',
            backgroundColor: Colors.green.withOpacity(.4),
          );
        } else {
          Get.snackbar(
            'Error',
            'Failed to save Result',
            backgroundColor: Colors.red.withOpacity(.4),
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to capture Result',
          backgroundColor: Colors.red.withOpacity(.4),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Exception',
        e.toString(),
        backgroundColor: Colors.red.withOpacity(.4),
      );
    }
  }

  /// Asked form AI
  Future<void>askedFromAi()async {}


  /// Image Process
  Future<void>imagePrecess()async {}



}
