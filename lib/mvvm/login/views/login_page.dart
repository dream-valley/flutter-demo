import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/mvvm/login/controllers/controller.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/string_util.dart';
import 'package:trip_flutter/util/validate.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/input_widget.dart';
import 'package:trip_flutter/widget/login_button.dart';
import 'package:trip_flutter/widget/rerify_code_input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends GetView<LoginViewModel> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
            children: [
              ..._background(),
              _content()
            ]
        )
    );
  }

  _background(){
    return [
      Positioned.fill(child: Image.asset("images/bg1.jpg", fit: BoxFit.cover)),
      Positioned.fill(child: Container(decoration: const BoxDecoration(color: Colors.black54)))
    ];
  }

  _content() {
    return Positioned.fill(
        left: 25,
        right: 25,
        child: ListView(
            children:  [
              hiSpace(height: 100),

              const Text("用户登录", style: TextStyle(
                color: Colors.white,
                fontSize: 26,
              )),


              hiSpace(height: 40),
              InputWidget("请输入手机号", onChanged: (text) {
                return controller.onValueChanged(text, LoginInputType.phone);
              }, keyboardType: TextInputType.number,),

              hiSpace(height: 40),
              VerificationCodeInput(
                hintText: '请输入验证码',
                countDown: 3, // TODO 线上 60 秒
                onChanged: (_code) {
                  return controller.onValueChanged(_code, LoginInputType.code);
                },
                onSendCode: () async {
                  // 这里实现发送验证码的逻辑
                  if (!isValidPhone(controller.phone)) {
                    // TODO 手机号校验失败
                    return false;
                  }
                  await Future.delayed(Duration(seconds: 1)); // 模拟网络请求
                  return true; // 返回发送是否成功
                },
              ),
              hiSpace(height: 40),
              LoginButton('登录', enable: controller.loginEnable.value, onPressed: () => controller.login()),
              hiSpace(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(onTap: () => controller.jumpRegistration(), child: const Text("注册账号", style: TextStyle(color: Colors.white))),
              )
            ]
        )
    );
  }


}
