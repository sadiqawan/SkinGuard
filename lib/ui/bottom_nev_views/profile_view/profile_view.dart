import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:test_firebase/constants/const_colors.dart';
import 'package:test_firebase/constants/const_text_style.dart';
import 'package:test_firebase/ui/bottom_nev_views/profile_view/profile_view_controller.dart';

import '../../../componants/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}

Widget _screen(BuildContext context) {
  ProfileViewController profileViewController =
      Get.put(ProfileViewController());
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30.h,
        ),
        Text(
          'PROFILE',
          style: kHeading2B,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Center(
            child: SizedBox(
              height: 200.h,
              width: 200.w,
              child: Image.asset('assets/images/icon_profile.png'),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Get.bottomSheet(
                backgroundColor: kWhit,
                SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Update Your Pic',
                          style: kHeading2B,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                                child: CustomButton(
                                    title: 'Select Camera',
                                    onTap: () {
                                      profileViewController
                                          .pickImageFrom(ImageSource.camera);
                                    })),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                              child: CustomButton(
                                  title: 'Select Gallery',
                                  onTap: () {
                                    profileViewController
                                        .pickImageFrom(ImageSource.gallery);
                                  }),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Update Pic',
                style: kSubTitle2B,
              ),
              const Icon(Icons.edit_outlined),
            ],
          ),
        ),
        _widget(Icons.person_outline, 'Name'),
        _widget(Icons.email_outlined, 'Email'),
        _widget(Icons.watch_later_outlined, 'Time'),
        InkWell(
          onTap: () {
            Get.dialog(
              AlertDialog(
                backgroundColor: Colors.black,
                // Set the background color of the dialog
                title: Text(
                  'Logout Confirmation',
                  style: kSubTitle1.copyWith(color: kWhit),
                ),
                content: Text(
                  'Are you sure you want to log out?',
                  style: kSmallTitle1.copyWith(color: kWhit),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: kSmallTitle1.copyWith(color: kWhit),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      profileViewController.logout();
                    },
                    child: Text(
                      'Logout',
                      style: kSmallTitle1.copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
          child: _widget(Icons.login_outlined, 'Logout'),
        ),
      ],
    ),
  );
}

Widget _widget(IconData icon, String value) {
  return ListTile(
    leading: Icon(
      icon,
      size: 40,
    ),
    title: Text(
      value,
      style: kSubTitle2B,
    ),
  );
}
