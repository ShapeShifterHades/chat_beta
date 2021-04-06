import 'package:flutter/material.dart';

import 'view/login_view.dart';

/// This page will be a replace for old Login page
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      // ignore: close_sinks

      return LoginView();
    });
  }
}
