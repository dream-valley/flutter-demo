import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  const InputWidget( this.hint,{
    super.key,
    this.obscureText = false,
    this.onChanged,
    this.keyboardType
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _input(),
        const Divider(color: Colors.white, height: 1, thickness: 0.5)
      ],
    );
  }

  _input(){
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofocus: !obscureText,
      style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400
      ),
      cursorColor: Colors.white,
      decoration: InputDecoration(border: InputBorder.none, hintText: hint,
          hintStyle: const TextStyle(fontSize: 16, color: Colors.grey)
      ),
    );
  }
}
