import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


// Flutter 通过 cookie 的方式将登录态同步给 H5
class FlutterH5LoginSyncByCookie extends StatefulWidget {
  const FlutterH5LoginSyncByCookie({super.key});

  @override
  State<FlutterH5LoginSyncByCookie> createState() => _FlutterH5LoginSyncByCookieState();
}

class _FlutterH5LoginSyncByCookieState extends State<FlutterH5LoginSyncByCookie> {
  WebViewCookieManager cookieManager = WebViewCookieManager();
  late WebViewController controller;

  get _loadBtn => FilledButton(onPressed: (){
    controller.loadRequest(Uri.parse('https://geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=geekailab'));
  }, child: const Text('加载H5'));

  get _setCookieBtn => FilledButton(onPressed: (){
    _onSetCookie(context);
  }, child: const Text('设置 Cookie'));

  get _clearCookieBtn => FilledButton(onPressed: (){
    _onClearCookie(context);
  }, child: const Text('清除 Cookie'));

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter h5 cookie 同步状态数据'), actions: [_loadBtn, _setCookieBtn, _clearCookieBtn]),
        body:Stack(
          children: [
            WebViewWidget(controller: controller)
          ],
        )
    );
  }

  // 设置 cookie
  void _onSetCookie(BuildContext context) async {
    try {
      await cookieManager.setCookie(const WebViewCookie(
        name: 'token', //cookie的名字
        value: 'sfsdfsfwer123123fdasd', //cookie的值
        domain: 'geekailab.com', //指定给对应的域名设置cookie
        path: '/', //域名下的路径，可以缺省，若设置一个具体的path，那么只有这个path下的网址才可以获取到设置的cookie
      ));

      await cookieManager.setCookie(
          const WebViewCookie(
              name: 'uid',
              value: '14110100808',
              domain: 'geekailab.com',
              path: ""
          )
      );


      final Object cookiea =  await controller.runJavaScriptReturningResult('document.cookie');
      debugPrint('cookie $cookiea');
    } catch(e){
      debugPrint('e $e');
    }



    // 在 flutter 中获取 cookie
    final Object cookie1 =  await controller.runJavaScriptReturningResult('document.cookie');
    debugPrint(cookie1.toString());

  }

  void _onClearCookie(BuildContext context) async{
    await cookieManager.clearCookies();

    final Object cookie =  await controller.runJavaScriptReturningResult('document.cookie');
    debugPrint('清除 cookie : $cookie');
  }
}
