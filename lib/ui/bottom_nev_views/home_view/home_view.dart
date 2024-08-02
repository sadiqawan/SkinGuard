import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_firebase/constants/const_colors.dart';
import 'package:test_firebase/constants/const_text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.only(top: 50.h, right: 16.w, left: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                maxRadius: 30.sp,
                backgroundColor: Colors.transparent,
                backgroundImage:
                    const AssetImage("assets/images/icon_person.png"),
              ),
              SizedBox(
                width: 5.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome To 👋",
                    style: kSubTitle2B,
                  ),
                  Text(
                    //mobile number
                    "Your Trusted Companion",
                    style: kSubTitle2B.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Stack(
              children: [

                Container(
                  height: 150.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: kPriemryColor,
                      borderRadius: BorderRadius.circular(15)),
                ),
                Image.asset(
                  'assets/images/image_doctor.png',
                  height: 172.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 2.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Empowering You with',
                          style: kSubTitle2B,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          textAlign: TextAlign.center,
                          'Advanced Technology',
                          style: kSubTitle2B,
                        ),
                      ),
                    ],
                  ),
                ),Padding(
                  padding: EdgeInsets.only(top: 50.h, left: 37.w ,right: 60.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Image.asset('assets/images/icon_bulb.png',height: 43.h,)
                      ),
                      SizedBox(width: .2.w,),
                      Flexible(
                          child: Image.asset('assets/images/icon_tec.png',height: 43.h)

                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Skin Awareness',style: kSubTitle2B,), Text('SeeAll',style: kSubTitle2B.copyWith(color: kPriemryColor),)
            ],
          )

        ],
      ),
    ),
  );
}
