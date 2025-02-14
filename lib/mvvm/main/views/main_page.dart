import 'package:flutter/material.dart';
import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:trip_flutter/mvvm/main/views/bottom_tab_view.dart';

import '../../../dao/login_dao.dart';
import '../../../navigator/tab_navigator.dart';
import '../../../pages/login_page.dart';
import '../../../util/screen-adapter-helper.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(future: _doInit(), builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      ScreenHelper.init(context);

      if (snapshot.connectionState == ConnectionState.done){
        if (LoginDao.getBordingPass() == null){
          return const LoginPage();
        } else {
          print('tab navigator');
          // return const TabNavigator();
          return const BottomTabView();
        }
      } else {
        return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
      }
    });
  }

  Future<void> _doInit ()async{
    await HiCache.preInit();

    // 关闭启动屏幕
  }
}
