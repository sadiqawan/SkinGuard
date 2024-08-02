import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_firebase/componants/custom_button.dart';
import 'package:test_firebase/constants/const_colors.dart';
import 'package:test_firebase/constants/const_text_style.dart';

import 'image_process_controller.dart';

class ImageProcessScreen extends StatelessWidget {
  const ImageProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  final ImageProcessController imageProcessController = Get.put(ImageProcessController());

  return Scaffold(
    floatingActionButton: _floatingActionButton(imageProcessController),
    body: Padding(
      padding: EdgeInsets.only(top: 50.h, right: 16.w, left: 16.w),
      child: Column(
        children: [
          Container(
            height: 300.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                  image: AssetImage('assets/images/scan_me.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                    child: CustomButton(
                        title: 'Select Camera',
                        onTap: () {
                          // imageProcessController.pickImage(ImageSource.camera);
                        })),
                SizedBox(
                  width: 5.w,
                ),
                Flexible(
                    child: CustomButton(
                        title: 'Select Gallery',
                        onTap: () {
                          // imageProcessController.pickImage(ImageSource.gallery);
                        }
                        ),
                ),
              ],
            ),
          ),
          CustomButton(
              title: 'Process Me',
              onTap: () {
                // imageProcessController.getDiseaseStatus();
                // Get.to(() => const ResultScreen());
              }),
        ],
      ),
    ),
  );
}

Widget _floatingActionButton(ImageProcessController imageProcessController) {
  return InkWell(
    onTap: () {
      imageProcessController.askedFromAi();
    },
    child: Container(
      width: 150.w,
      height: 50.h,
      decoration: BoxDecoration(
        // color: Colors.black,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: kPriemryColor)),
      child: Center(
        child: Text(
          'Asked From AI⚡',
          style: kSmallTitle1.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
