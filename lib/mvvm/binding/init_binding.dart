import 'package:get/get.dart';
import 'package:trip_flutter/mvvm/login/binding/login_binding.dart';
import 'package:trip_flutter/mvvm/main/binding/main_binding.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    MainBinding().dependencies();
    LoginBinding().dependencies();
  }
}