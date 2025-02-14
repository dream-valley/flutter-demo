

import 'package:get/get.dart';
import 'package:trip_flutter/util/string_util.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../dao/login_dao.dart';
import '../../../util/navigator_util.dart';

enum LoginInputType {
  phone, code
}


class LoginViewModel extends GetxController {
  final loginEnable = false.obs;

  String? phone;
  String? code;

  void onValueChanged(String value, LoginInputType type) {
    if (type == LoginInputType.phone) {
      phone = value;
    } else {
      code = value;
    }

    loginEnable(
      isNotEmpty(phone) && isNotEmpty(code)
    );
  }


  login() async{
    try {
      print('登录开始');
      var reslut = await LoginDao.login(username: '17615004096', password: '1qazxsw2');
      print('login result; $reslut');

      NavigatorUtil.goToHome();

    } catch(e){
      NavigatorUtil.goToHome();
      print('登录失败 e: $e');
    }
  }

  jumpRegistration() async{
    Uri uri = Uri.parse("https://api.devio.org/uapi/swagger-ui.html#/Account/registrationUsingPOST");

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "无法打开 url";
    }
  }
}