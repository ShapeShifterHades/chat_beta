import 'package:flutter/material.dart';

import 'package:void_chat_beta/ui/drawer/portrait_mobile_drawer/portrait_drawer_wrapper.dart';

class ChatlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PortraitMobileUI(
      routeName: 'Messages',
      child: Container(
        color: Colors.amber.withOpacity(0.4),
        child: Text(
          'MessageList content',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
