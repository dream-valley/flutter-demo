import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5Flutter2JSByrunJavaScript = '''
  <!DOCTYPE html>
  <html lang="zh">
  
  <head>
      <meta charset="utf-8">
      <title>Flutter向H5传递数据-通过runJavaScript</title>
      <script type="text/javascript">
          function hiCallJs(msg) {
              document.getElementById('resultTxt').innerHTML = 'Flutter传递过来的数据：' + msg;
          }
          function hiCallJsWithResult(v1, v2) {
              return parseInt(v1) + parseInt(v2);
          }
      </script>
  </head>
  
  <body>
      <div id="resultTxt" style="font-size: 2.5em">这里展示Flutter传递过来的数据</button>
  </body>
  
  </html>
''';


class Flutter2jsByRunJavascript extends StatefulWidget {
  const Flutter2jsByRunJavascript({super.key});

  @override
  State<Flutter2jsByRunJavascript> createState() => _Flutter2jsByRunJavascriptState();
}

class _Flutter2jsByRunJavascriptState extends State<Flutter2jsByRunJavascript> {

  late WebViewController controller;


  get _loadBtn => FilledButton(onPressed: (){
    controller.loadHtmlString(h5Flutter2JSByrunJavaScript );
    // controller.loadFile(absoluteFilePath)

  }, child: const Text('加载H5'));

  get _fireData => FilledButton(onPressed: () async{
    var name = "+++---+++";
    // 要在H5页面加载完后进行, 否测会报错: Failed evaluating Javascript
    controller.runJavaScript('hiCallJs("$name")');

    // 如果函数是有返回值的
    var result = await controller.runJavaScriptReturningResult('hiCallJsWithResult(1,2)');
    debugPrint('js 计算结果: $result');
  }, child: const Text('传递数据'));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Flutter向js传递数据-runjs'), actions: [_loadBtn, _fireData]),
        body:Stack(
          children: [
            WebViewWidget(controller: controller)
          ],
        )
    );
  }



}
