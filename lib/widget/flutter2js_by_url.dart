import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


/// flutter 通过 url 向 js 传递数据
class Flutter2jsByUrl extends StatefulWidget {
  const Flutter2jsByUrl({super.key});

  @override
  State<Flutter2jsByUrl> createState() => _Flutter2jsByUrlState();
}

class _Flutter2jsByUrlState extends State<Flutter2jsByUrl> {
  int progress = 0;
  late WebViewController controller;

  get _loadBtn => FilledButton(onPressed: (){
    controller.loadRequest(Uri.parse('https://www.geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=geekailab'));
    // controller.loadFile(absoluteFilePath)

  }, child: const Text('加载H5'));

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(onProgress:(progress){
      setState(() {
        this.progress = progress;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter向js传递数据'), actions: [_loadBtn]),
      body:Stack(
        children: [
          WebViewWidget(controller: controller),
          Positioned(bottom:100, child: Text('加载进度: $progress'))
        ],
      )
    );
  }
}
