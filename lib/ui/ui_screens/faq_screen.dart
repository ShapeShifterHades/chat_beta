import 'package:flutter/material.dart';

import '../portrait_mobile_ui.dart';

class FaqScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PortraitMobileUI(
      routeName: 'FAQ',
      content: Container(
        color: Colors.amber.withOpacity(0.4),
        child: Text(
          ModalRoute.of(context).settings.name ?? 'faq route',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
