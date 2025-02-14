import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/model/home_model.dart';
import 'package:trip_flutter/util/navigator_util.dart';

/// 首页接口
class HomeDao {
  static Future<HomeModel> fetch() async {
    var url = Uri.parse('https://api.geekailab.com/uapi/ft/home');

    final response = await http.get(url, headers: hiHeaders());

    Utf8Decoder utf8Decoder = const Utf8Decoder();

    String bodyString = utf8Decoder.convert(response.bodyBytes);

    debugPrint(bodyString);

    if ( response.statusCode == 200 ) {
      var res = json.decode(bodyString);
      return HomeModel.fromJson(res['data']);
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }
      throw Exception(bodyString);
    }
  }
}