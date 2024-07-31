import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_firebase/ui/bottom_nev_views/search_view/search_view_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _screen(context);
  }
}


Widget _screen(BuildContext context){
  SearchViewController searchViewController = Get.put(SearchViewController());

  return Scaffold();
}