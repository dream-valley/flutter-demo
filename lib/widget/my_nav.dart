import 'package:flutter/material.dart';

/// 自定义 navbar

class CustomBottomNavigator extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigator({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  // 记录每个item是否处于按压状态
  final List<bool> _isPressedList = List.generate(4, (_) => false);

  final List<_NavItem> _items = [
    _NavItem(
      title: '首页',
      activeIcon: 'images/tab1-active.png',    // 选中时的图片
      inactiveIcon: 'images/tab1.png',  // 未选中时的图片
    ),
    _NavItem(
      title: '搜索',
      activeIcon: 'images/tab1-active.png',    // 选中时的图片
      inactiveIcon: 'images/tab1.png',  // 未选中时的图片
    ),
    _NavItem(
      title: '旅拍',
      activeIcon: 'images/tab1-active.png',    // 选中时的图片
      inactiveIcon: 'images/tab1.png',  // 未选中时的图片
    ),
    _NavItem(
      title: '我的',
      activeIcon: 'images/tab1-active.png',    // 选中时的图片
      inactiveIcon: 'images/tab1.png',  // 未选中时的图片
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      elevation: 8,
      child: Container(
        color: Colors.white,
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isSelected = widget.currentIndex == index;

            return GestureDetector(
              onTapDown: (_) {
                setState(() {
                  _isPressedList[index] = true;
                });
              },
              onTapUp: (_) {
                setState(() {
                  _isPressedList[index] = false;
                });
                widget.onTap(index);
              },
              onTapCancel: () {
                setState(() {
                  _isPressedList[index] = false;
                });
              },
              child: AnimatedScale(
                scale: _isPressedList[index] ? 0.9 : 1.0,  // 按压时缩小到0.8倍
                duration: const Duration(milliseconds: 100),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        isSelected ? item.activeIcon : item.inactiveIcon,
                        width:20,
                        height: 20,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected ? Colors.blue : Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _NavItem {
  final String title;
  final String activeIcon;    // 选中状态图片路径
  final String inactiveIcon;  // 未选中状态图片路径

  _NavItem({
    required this.title,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}