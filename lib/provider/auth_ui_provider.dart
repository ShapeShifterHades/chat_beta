import 'package:flutter/material.dart';

class AuthUiProvider extends ChangeNotifier {
  bool _isLogin = false;
  AnimationController _slideInController;
  Animation<Offset> _slideInAnimation;

  bool get loginState => _isLogin;

  void change() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
}
