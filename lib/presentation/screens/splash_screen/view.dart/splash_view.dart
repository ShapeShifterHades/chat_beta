import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class SplashView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: Text('Loading...', style: TextStyles.h2),
      ),
    );
  }
}
