import 'package:flutter/material.dart';

class AuthUiProvider extends ChangeNotifier {
  bool _isLogin = false;

  bool get loginState => _isLogin;

  void change() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
}
