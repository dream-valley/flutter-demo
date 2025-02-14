import 'package:flutter/material.dart';
import 'package:trip_flutter/dao/login_dao.dart';
import 'package:trip_flutter/util/navigator_util.dart';
import 'package:trip_flutter/util/string_util.dart';
import 'package:trip_flutter/util/validate.dart';
import 'package:trip_flutter/util/view_util.dart';
import 'package:trip_flutter/widget/input_widget.dart';
import 'package:trip_flutter/widget/login_button.dart';
import 'package:trip_flutter/widget/rerify_code_input_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool loginEnable = false;

  String? phone;
  String? code;

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
              phone = text;
              _checkInput();
            }, keyboardType: TextInputType.number,),

            hiSpace(height: 40),
            VerificationCodeInput(
              hintText: '请输入验证码',
              countDown: 3, // TODO 线上 60 秒
              onChanged: (_code) {
                print('验证码: $_code');
                code = _code;
                _checkInput();
              },
              onSendCode: () async {
                // 这里实现发送验证码的逻辑
                print('发送验证码: $phone');
                if (!isValidPhone(phone)) {
                // TODO 手机号校验失败
                  return false;
                }
                await Future.delayed(Duration(seconds: 1)); // 模拟网络请求
                return true; // 返回发送是否成功
              },
            ),
            hiSpace(height: 40),
            LoginButton('登录', enable: loginEnable, onPressed: () => _login(context)),
            hiSpace(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(onTap: () => _jumpRegistration(), child: const Text("注册账号", style: TextStyle(color: Colors.white))),
            )
          ]
        )
    );
  }

  void _checkInput(){
    bool enable;
    if ( isNotEmpty(phone) && isNotEmpty(code) ) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
      print('enable $enable');
    });
  }

  _login(context) async{
    try {
      print('登录开始');
      var reslut = await LoginDao.login(username: '17615004096', password: '1qazxsw2');
      print('login result; $reslut');

      // FIXME 用了 GETX 托管路由跳转后, 不需要传入 context
      // NavigatorUtil.goToHome(context);
      NavigatorUtil.goToHome();

    } catch(e){
      // FIXME 用了 GETX 托管路由跳转后, 不需要传入 context
      // NavigatorUtil.goToHome(context);
      NavigatorUtil.goToHome();
      print('登录失败 e: $e');
    }
  }

  _jumpRegistration() async{
    Uri uri = Uri.parse("https://api.devio.org/uapi/swagger-ui.html#/Account/registrationUsingPOST");

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw "无法打开 url";
    }
  }
}
