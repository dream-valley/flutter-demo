import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/main/controllers/controller.dart';
import 'package:trip_flutter/widget/my_nav.dart';

import '../../../pages/home_page.dart';
import '../../../pages/my_page.dart';
import '../../../pages/search_page.dart';
import '../../../pages/travel_page.dart';

/// 首页底部导航器

class BottomTabView extends GetView<MainViewModel>{
  final _defaultColor = Colors.black45;
  final _activeColor = Colors.blue;

  const BottomTabView({super.key});

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
      body: PageView(
        controller: controller.controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: _currentIndex,
      //     onTap: (index){
      //       _controller.jumpToPage(index);
      //       setState(() {
      //         _currentIndex = index;
      //       });
      //     },
      //     fixedColor: _activeColor,
      //     // selectedItemColor: _activeColor,  // 用 fixedColor 也可以解决文字颜色不生效的问题
      //     // unselectedItemColor: _defaultColor,
      //     type: BottomNavigationBarType.shifting,
      //     items: [
      //       _bottomItem("首页", Icons.home_outlined, 0),
      //       _bottomItem("搜索", Icons.search, 1),
      //       _bottomItem("旅拍", Icons.camera_alt_outlined, 2),
      //       _bottomItem("我的", Icons.account_circle_outlined, 3),
      //     ]
      // ),
      bottomNavigationBar: CustomBottomNavigator(
        currentIndex: controller.currentIndex.value,
        onTap: controller.onBottomNavTap
      )
    ));
  }

  _bottomItem(String title, IconData icon, int index){
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }
}