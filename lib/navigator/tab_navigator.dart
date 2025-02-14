import 'package:flutter/material.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/my_page.dart';
import 'package:trip_flutter/pages/search_page.dart';
import 'package:trip_flutter/pages/travel_page.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/widget/my_nav.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _currentIndex = 0;
  final _defaultColor = Colors.black45;
  final _activeColor = Colors.blue;
  final PageController _controller = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {

    NavigatorUtil.updataContext(context);

    return Scaffold(
      body: PageView(
        controller: _controller,
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
        currentIndex: _currentIndex,
        onTap: (index) {
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index){
    return BottomNavigationBarItem(
        icon: Icon(icon, color: _defaultColor),
        activeIcon: Icon(icon, color: _activeColor),
        label: title,
    );
  }
}
