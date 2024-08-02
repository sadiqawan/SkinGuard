import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_firebase/constants/const_text_style.dart';
import '../../../../componants/custom_back_button.dart';


class AwarenessDetailsScreen extends StatelessWidget {
  final String dr_image;
  final String image;
  final String name;
  final String discreption;
  const AwarenessDetailsScreen({super.key, required this.dr_image, required this.name, required this.discreption, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 40.h, right: 16.w, left: 16.w),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const CustomBackButton(),
            SizedBox(
              height: 7.h,
            ),

            Image.asset(image,width: double.infinity,height: 200.h,fit: BoxFit.cover,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text(name,style: kSubTitle2B,)),Flexible(child: Image.asset(dr_image,height: 150.h,))
              ],
            ),
            Expanded(child: SingleChildScrollView(child: Text(discreption,style: kSubTitle1,)))

          ],
        ),
      ),
    );
  }
}
