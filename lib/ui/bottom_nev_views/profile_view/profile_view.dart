import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_firebase/ui/bottom_nev_views/profile_view/profile_view_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewController profileViewController = Get.put(ProfileViewController());
    return const Placeholder();
  }
}
