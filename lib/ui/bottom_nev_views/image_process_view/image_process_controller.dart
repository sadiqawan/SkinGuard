import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:screenshot/screenshot.dart';

class ImageProcessController extends GetxController {
  final ScreenshotController screenshotController = ScreenshotController();




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
