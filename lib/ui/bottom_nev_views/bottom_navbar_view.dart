import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:test_firebase/constants/const_colors.dart';
import 'package:test_firebase/controllers/app-_controller/app_controller.dart';
import 'package:test_firebase/ui/bottom_nev_views/home_view/home_view.dart';
import 'package:test_firebase/ui/bottom_nev_views/image_process_view/image_process_view.dart';
import 'package:test_firebase/ui/bottom_nev_views/profile_view/profile_view.dart';
import 'package:test_firebase/ui/bottom_nev_views/search_view/search_view.dart';

class BottomNavbarScreen extends StatelessWidget {
  const BottomNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppController appController = Get.put(AppController());
    List screens = const [
      HomeScreen(),
      ImageProcessScreen(),
      SearchScreen(),
      ProfileScreen()
    ];

    return Obx(() => Scaffold(
          body: screens[appController.currentIndex.value],
          bottomNavigationBar: Padding(
            padding:  EdgeInsets.only(left: 7.w,right: 7.w,bottom: 10.h),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: kPriemryColor,
              ),
              child: SalomonBottomBar(
              
                  duration: const Duration(milliseconds: 900),
                selectedColorOpacity: .3,

                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.white,
                onTap: (index) {
                  appController.currentIndex.value = index;
                },
                currentIndex: appController.currentIndex.value,
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.home_outlined,
                      size: 27,
                    ),
                    title: const Text("Home"),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.batch_prediction_outlined,
                      size: 27,

                    ),
                    title: const Text("predict"),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.search_outlined,
                      size: 27,

                    ),
                    title: const Text("Search"),
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.person_outline,
                      size: 27,

                    ),
                    title: const Text("Profile"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
