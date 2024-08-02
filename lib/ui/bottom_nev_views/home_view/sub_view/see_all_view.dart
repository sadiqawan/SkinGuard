import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../componants/custom_back_button.dart';
import '../../../../componants/custtom_awarnes_card.dart';
import '../../../../constants/const_colors.dart';
import '../../../../constants/const_text_style.dart';
import '../home_controller.dart';
import 'awareness_details_view.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    List data = homeController.awareness;

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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Skin Awareness:',
                style: kSubTitle2B,
              ),
            ),
            Text(
              'Skin Awareness is crucial for early detection and prevention of skin diseases and conditions, promoting overall skin health and encouraging regular self-examinations and professional check-ups',
              style: kSubTitle1.copyWith(fontSize: 12.sp),
            ),
            SizedBox(
              height: 4.h,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CusttomAwarnesCard(
                        onTap: () {
                          Get.to(() => AwarenessDetailsScreen(
                                dr_image: data[index]['dr_image'],
                                name: data[index]['name'],
                                discreption: data[index]['description'],
                                image: data[index]['image'],
                              ),
                          );
                        },
                        drImage: data[index]['dr_image'],
                        name: data[index]['name'],
                        shortDes: data[index]['shortDes'],
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
