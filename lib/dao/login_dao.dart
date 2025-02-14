/// 登录接口
import 'dart:convert';
import 'package:dio/dio.dart';


import 'package:flutter_hi_cache/flutter_hi_cache.dart';
import 'package:http/http.dart' as http;
import 'package:trip_flutter/dao/header_util.dart';
import 'package:trip_flutter/util/navigator_util.dart';

class LoginDao {
  static const boardingPass = "boarding_pass";

  static login({required String username, required String password}) async {
    Map<String,String> paramsMap = {};
    paramsMap["userName"] = username;
    paramsMap['password'] = password;
    paramsMap['course-flag'] = "ft";

    // final dio = Dio();
    // try {
    //   final response = await dio.post(
    //     'https://api.devio.org/uapi/user/login',
    //     queryParameters: paramsMap,
    //     options: Options(headers: hiHeaders()),
    //   );
    //
    //   if (response.statusCode == 200) {
    //     var result = response.data;
    //
    //     print("登录 bodyString $result");
    //     if (result['code'] == 0 && result['data'] != null) {
    //       _saveBoardingPass(result['data']);
    //     } else {
    //       throw Exception(result.toString());
    //     }
    //   }
    // } catch (e) {
    //   print('请求异常: $e');
    //   throw Exception('请求失败: $e');
    // }

    var uri =  Uri.https('api.devio.org', '/uapi/user/login', paramsMap);

    final response = await http.post(uri, headers: hiHeaders());
    Utf8Decoder utf8decoder = const Utf8Decoder(); // 解决中文乱码
    String bodyString = utf8decoder.convert(response.bodyBytes);
    print("登录 bodyString $bodyString");

    if (response.statusCode == 200) {
      var result = json.decode(bodyString);
      if (result['code'] == 0 && result['data'] != null) {
        // 保存登录令牌
        _saveBoardingPass(result['data']);
      } else {
        throw Exception(bodyString);
      }
    } else {
      throw Exception(bodyString);
    }
  }

  static void _saveBoardingPass(String value){
    HiCache.getInstance().setString(boardingPass, value);
  }

  static getBordingPass(){
    return HiCache.getInstance().get(boardingPass);
  }

  static void logout(){
    // 移除令牌
    HiCache.getInstance().remove(boardingPass);

    // 登录页  navigator navigator2
    NavigatorUtil.goToLogin();
  }
}