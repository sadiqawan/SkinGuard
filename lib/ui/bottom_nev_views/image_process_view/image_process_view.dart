import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_firebase/componants/custom_button.dart';
import 'package:test_firebase/ui/bottom_nev_views/image_process_view/sub_views/result_view.dart';
import 'image_process_controller.dart';

class ImageProcessScreen extends StatelessWidget {
  const ImageProcessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  ImageProcessController imageProcessController =
      Get.put(ImageProcessController());

  return Scaffold(
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
                Flexible(child: CustomButton(title: 'Select Camera', onTap: (){})),
                SizedBox(width: 5.w,),
                Flexible(child: CustomButton(title: 'Select Gallery', onTap: (){}))
              ],
            ),
          ),
          CustomButton(title: 'Process Me', onTap: (){
            Get.to(()=> ResultScreen());
          }),

        ],
      ),
    ),
  );
}
