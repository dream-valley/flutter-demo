import 'package:flutter/material.dart';
import 'package:trip_flutter/widget/flutter2js_by_run_javascript.dart';
import 'package:trip_flutter/widget/flutter2js_by_url.dart';
import 'package:trip_flutter/widget/flutter_h5_login_sync_by_cookie.dart';
import 'package:trip_flutter/widget/flutter_h5_sync_by_channel.dart';
import 'package:trip_flutter/widget/hi_webview.dart';
import 'package:trip_flutter/widget/js2flutter_by_channel.dart';
import 'package:trip_flutter/widget/js2flutter_by_url.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with  AutomaticKeepAliveClientMixin  {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: const Text('我的'),),
      // body: HiWebView(
      //   url: 'https://m.ctrip.com/webapp/myctrip',
      //   hideAppBar: true,
      //   backForbid: true,
      //   statusBarColor: '0176aa',
      // ),
      body: Column(
        children: [
          _navButton(context, Js2flutterByUrl(), 'js => Flutter 通过 url 传递数据'),
          _navButton(context, Js2flutterByChannel(), 'js => Flutter 通过 channel 传递数据'),
          _navButton(context, Flutter2jsByUrl(), 'flutter => js 通过 url 传递数据'),
          _navButton(context, Flutter2jsByRunJavascript(), 'flutter => js 通过 runJavascript 传递数据'),
          _navButton(context, FlutterH5LoginSyncByCookie(), 'flutter H5 登录态共享 - cookie'),
          _navButton(context, FlutterH5LoginChannel(), 'flutter H5 登录态共享 - channel')

        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  _navButton(BuildContext context, Widget page, String title) {
    return FilledButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
    }, child: Text(title));
  }
}
