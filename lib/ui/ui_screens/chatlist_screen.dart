import 'package:flutter/material.dart';

import '../portrait_mobile_ui.dart';

class ChatlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PortraitMobileUI(
      routeName: 'Messages',
      content: Container(
        color: Colors.amber.withOpacity(0.4),
        child: Text(
          'MessageList content',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
