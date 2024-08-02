import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_firebase/constants/const_colors.dart';
import 'package:test_firebase/constants/const_text_style.dart';
import 'package:test_firebase/ui/bottom_nev_views/home_view/home_controller.dart';
import 'package:test_firebase/ui/bottom_nev_views/home_view/sub_view/awareness_details_view.dart';
import 'package:test_firebase/ui/bottom_nev_views/home_view/sub_view/see_all_view.dart';
import '../../../componants/custtom_awarnes_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  HomeController homeController = Get.put(HomeController());
  return Scaffold(
    body: Padding(
      padding: EdgeInsets.only(top: 50.h, right: 16.w, left: 16.w),
      child: SingleChildScrollView(
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
              padding: EdgeInsets.only(top: 15.h, bottom: 2.h),
              child: Stack(
                children: [
                  Container(
                    height: 150.h,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: kPriemryColor.withOpacity(.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: kPriemryColor)),
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
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 50.h, left: 37.w, right: 60.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Image.asset(
                          'assets/images/icon_bulb.png',
                          height: 43.h,
                        )),
                        SizedBox(
                          width: .2.w,
                        ),
                        Flexible(
                            child: Image.asset('assets/images/icon_tec.png',
                                height: 43.h)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Skin Awareness',
                  style: kSubTitle2B,
                ),
                InkWell(
                    onTap: () {
                      Get.to(() => const SeeAllScreen());
                    },
                    child: Text(
                      'SeeAll',
                      style: kSubTitle2B.copyWith(color: kPriemryColor),
                    ))
              ],
            ),
            SizedBox(
              height: 500,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    List data = homeController.awareness;
                    return CusttomAwarnesCard(
                      onTap: () {
                        Get.to(() => AwarenessDetailsScreen(
                              dr_image: data[index]['dr_image'],
                              name: data[index]['name'],
                              discreption: data[index]['description'],
                          image: data[index]['image'],
                            ));
                      },
                      drImage: data[index]['dr_image'],
                      name: data[index]['name'],
                      shortDes: data[index]['shortDes'],
                    );
                  }),
            )
          ],
        ),
      ),
    ),
  );
}
