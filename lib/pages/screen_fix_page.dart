import 'package:flutter/material.dart';
import 'package:trip_flutter/util/screen-adapter-helper.dart';

class ScreenFixPage extends StatefulWidget {
  const ScreenFixPage({super.key});

  @override
  State<ScreenFixPage> createState() => _ScreenFixPageState();
}

class _ScreenFixPageState extends State<ScreenFixPage> {
  @override
  Widget build(BuildContext context) {
    
    ScreenHelper.init(context);
    
    return const Placeholder();
  }
}
