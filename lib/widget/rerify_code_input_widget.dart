import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class VerificationCodeInput extends StatefulWidget {
  final Function(String)? onChanged; // 验证码输入回调
  final Future<bool> Function()? onSendCode; // 发送验证码回调
  final String? hintText;
  final int countDown;

  const VerificationCodeInput({
    Key? key,
    this.onChanged,
    this.onSendCode,
    this.hintText,
    this.countDown = 60
  }) : super(key: key);

  @override
  State<VerificationCodeInput> createState() => _VerificationCodeInputState();
}

class _VerificationCodeInputState extends State<VerificationCodeInput> {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  late int _countDown;
  bool _canSendCode = true;


  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  // 开始倒计时
  void _startCountDown() {
    setState(() {
      _canSendCode = false;
      _countDown = widget.countDown;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countDown <= 0) {
        timer.cancel();
        setState(() {
          _canSendCode = true;
        });
      } else {
        setState(() {
          _countDown--;
        });
      }
    });
  }

  // 发送验证码
  Future<void> _sendCode() async {
    if (!_canSendCode) return;

    if (widget.onSendCode != null) {
      try {
        bool success = await widget.onSendCode!();
        if (success) {
          _startCountDown();
        }
      } catch (e) {
        // 处理错误
        debugPrint(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return
    Column(children: [
      Container(
        decoration: const BoxDecoration(
          // border: Border.all(color: Colors.grey[300]!),
          // borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                cursorColor: Colors.white,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly, // 只允许输入数字
                  LengthLimitingTextInputFormatter(6), // 限制长度为6位
                ],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText ?? '请输入验证码',
                  border: InputBorder.none,
                  // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey)
                ),
                onChanged: widget.onChanged,
              ),
            ),
            SizedBox(
              width: 120,
              child: TextButton(
                onPressed: _canSendCode ? _sendCode : null,
                child: Text(
                  _canSendCode ? '发送验证码' : '${_countDown}s后重发',
                  style: TextStyle(
                    color: _canSendCode ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const Divider(color: Colors.white, height: 1, thickness: 0.5)
    ],);
  }
}