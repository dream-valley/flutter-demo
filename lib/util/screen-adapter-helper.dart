import 'package:flutter/cupertino.dart';

/// 扩展 int
extension IntFix on int {
  double get px {
    return ScreenHelper.getPx(toDouble());
  }
}


extension DoubleFix on double {
  double get px {
    return ScreenHelper.getPx(this);
  }
}

class ScreenHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenW;
  static late double screenH;
  static late double ratio;

  static init (BuildContext ctx, {double baseWidth = 375}) {
    _mediaQueryData = MediaQuery.of(ctx);

    screenW = _mediaQueryData.size.width;
    screenH = _mediaQueryData.size.height;

    ratio = screenW / baseWidth;
  }

  static double getPx(double size){
    return ScreenHelper.ratio * size;
  }
}