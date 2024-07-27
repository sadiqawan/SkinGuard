

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_process_controller.dart';

class ImageProcessScreen extends StatelessWidget {
  const ImageProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ImageProcessController imageProcessController = Get.put(ImageProcessController());
    return const Placeholder();
  }
}
