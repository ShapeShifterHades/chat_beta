import 'package:flutter/material.dart';
import 'package:void_chat_beta/ui/portrait_mobile_ui.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PortraitMobileUI(
        routeName: 'FAQ',
        content: Container(
          color: Colors.amber.withOpacity(0.4),
          child: Text(
            ModalRoute.of(context).settings.name ?? 'faq route',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
