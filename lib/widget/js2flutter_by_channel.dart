import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


const String h5JS2FlutterByChannel = '''
  <!DOCTYPE html>
  <html lang="zh">
  
  <head>
      <meta charset="utf-8">
      <title>通过javascriptChannels向flutter传递参数</title>
  </head>
  
  <body>
      <button id="btn" style="font-size: 2.5em">通过javascriptChannels向flutter传递参数</button>
      <script type="text/javascript">
          var btn = document.getElementById("btn");
          btn.addEventListener('click', function () {
             //通过注册的hiPop channel向flutter发送消息
             hiPop.postMessage("Hi Pop");
          }, false)
      </script>
  </body>
  
  </html>
''';

/// js => flutter 通过 javascriptChannel 的方式传递数据
class Js2flutterByChannel extends StatefulWidget {

  const Js2flutterByChannel({super.key});

  @override
  State<Js2flutterByChannel> createState() => _Js2flutterByChannelState();
}

class _Js2flutterByChannelState extends State<Js2flutterByChannel> {
  late WebViewController controller;


  get _loadBtn => FilledButton(onPressed: (){
    controller.loadHtmlString(h5JS2FlutterByChannel);
    // controller.loadFile(absoluteFilePath)

  }, child: const Text('加载H5'));

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..addJavaScriptChannel('hiPop', onMessageReceived: (JavaScriptMessage message){
      debugPrint('onMessageReceived  $message');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message.message)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('JS向 Flutter传数据-channel'), actions: [_loadBtn],),
        body: WebViewWidget(controller: controller)
    );
  }
}
