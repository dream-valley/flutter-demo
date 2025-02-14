import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/routes/app_pages.dart';
import 'package:trip_flutter/navigator/tab_navigator.dart';
import 'package:trip_flutter/pages/home_page.dart';
import 'package:trip_flutter/pages/login_page.dart';
import 'package:trip_flutter/widget/hi_webview.dart';

class NavigatorUtil {
  // 在获取不到 context 的地方, 如在 dao 中跳转， 需要在 TabNavigator 中赋值
  // 如果 TabNavigator 被销毁, _context 将无法使用
  static BuildContext? _context;

  static updataContext(BuildContext context){
    NavigatorUtil._context = context;

    print('init: $context');
  }

  static push(BuildContext context, Widget page){
    /// push 这种方式跳转页面，是可以返回到上一页的
    // Navigator.push(context, MaterialPageRoute(builder: (context) => page));

    // 使用 getx 不需要传递 context
    Get.to(page);
  }

  /// 跳转到首页
  static goToHome(){
    /// 跳转到主页不让返回
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));

    // 跳转到主页，并不让返回, 移除以其他的页面栈
    // Get.offAll(const TabNavigator());

    // 当使用getx依赖注入后，需要使用路由名称跳转，才能确保依赖注入生效，切换页面的时候不丢失controller的状态
    Get.offAllNamed(Routes.MAIN);
  }

  /// 登录页
  static goToLogin(){
    // Navigator.pushReplacement(_context!, MaterialPageRoute(builder: (context) => const LoginPage()));
    // 跳转到 登录 并销毁上一个页面
    // Get.off(const LoginPage());

    Get.offNamed(Routes.LOGIN);
  }


  ///返回上一页
  static pop(BuildContext context) {
    // if (Navigator.canPop(context)) {
    //   Navigator.pop(context);
    // } else {
    //   //退出APP
    //   SystemNavigator.pop();
    // }
    //使用getx返回上一页
    Get.back();
  }

  /// 跳转H5
  static jumpH5 ({BuildContext? context, required String url, String? title, bool? hideAppBar, String? statusBarColor}){
    BuildContext? safeContext;

    // if (context != null) {
    //   safeContext = context;
    // } else if (_context?.mounted ?? false) {
    //   safeContext = _context;
    // } else {
    //   debugPrint('context 是 null , 跳转 H5 失败');
    // }
    // Navigator.push(
    //     safeContext!,
    //     MaterialPageRoute(
    //         builder: (context)=>HiWebView(url: url, title: title, hideAppBar: hideAppBar, statusBarColor: statusBarColor,)
    //     )
    // );

    Get.to(HiWebView(
      url: url,
      title: title,
      hideAppBar: hideAppBar,
      statusBarColor: statusBarColor,
    ));

  }
}