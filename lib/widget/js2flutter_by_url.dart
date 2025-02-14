import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


const String h5JS2FlutterByUrl = '''
  <!DOCTYPE html>
  <html lang="zh">
  
  <head>
      <meta charset="utf-8">
      <title>通过URL向flutter传递参数</title>
  </head>
  
  <body>
      <button id="btn" style="font-size: 2.5em">传递参数</button>
      <script type="text/javascript">
          var btn = document.getElementById("btn");
          btn.addEventListener('click', function () {
              //通过URL向flutter传递参数
              document.location = "hi://webview?name=geekailab";
          }, false)
      </script>
  </body>
  
  </html>
''';


// JS 通过 URL 向 Flutter 传递数据
class Js2flutterByUrl extends StatefulWidget {
  const Js2flutterByUrl({super.key});

  @override
  State<Js2flutterByUrl> createState() => _Js2flutterByUrlState();
}

class _Js2flutterByUrlState extends State<Js2flutterByUrl> {
  late WebViewController controller;

  get _loadBtn => FilledButton(onPressed: (){
    controller.loadHtmlString(h5JS2FlutterByUrl);
    // controller.loadFile(absoluteFilePath)
    
  }, child: const Text('加载H5'));


  @override
  void initState() {
    super.initState();

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (NavigationRequest request){

        // 约定一个通信协议 hi://webview
        if (request.url.startsWith("hi://webview")) {
          debugPrint('处理 js  通过 URL 传递的数据 $request');
          Uri uri = Uri.parse(request.url);

          var name = uri.queryParameters['name'];
          debugPrint('URL 传递的数据 name $name');

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('name: $name')));

          return NavigationDecision.prevent; // 不跳转
        }
        debugPrint('非 hi://webview 开头的 url 则跳转 $request');
        return NavigationDecision.navigate;

      }
    ));

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JS向 Flutter传数据'), actions: [_loadBtn],),
      body: WebViewWidget(controller: controller)
    );
  }
}
