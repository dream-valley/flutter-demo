
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

// TabNavgitator 的 ViewModel
class MainViewModel extends GetxController{
  final currentIndex = 0.obs;
  final PageController controller = PageController(initialPage: 0);

  void onBottomNavTap (int index){
    currentIndex(index);
    controller.jumpToPage(index);
  }
}