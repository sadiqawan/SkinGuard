import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../constants/const_colors.dart';
import '../constants/const_text_style.dart';

class CusttomAwarnesCard extends StatelessWidget {
  final String drImage;
  final String name;
  final String shortDes;
   final Function() onTap;

  const CusttomAwarnesCard(
      {super.key,
      required this.drImage,
      required this.name,
      required this.shortDes,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 120.h,
          width: Get.width,
          decoration: BoxDecoration(
              border: Border.all(color: kPriemryColor, width: 4),
              borderRadius: BorderRadius.circular(15),
              color: kPriemryColor.withOpacity(.3)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Text(
                  name,
                  style: kSmallTitle1B.copyWith(fontSize: 18.sp),

                ),
                Positioned(
                    top: 30,
                    child: Text(
                      shortDes,
                      style: kSmallTitle1,

                    ),
                ),
                Positioned(
                    top: -44,
                    right: -40,
                    child: Image.asset(
                      drImage,
                      height: 230,
                      width: 180,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
