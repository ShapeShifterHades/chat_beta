import 'package:flutter/material.dart';

import '../portrait_mobile_ui.dart';

class SecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PortraitMobileUI(
      routeName: 'Security',
      content: Container(
        color: Colors.amber.withOpacity(0.4),
        child: Text(
          ModalRoute.of(context).settings.name ?? 'security route',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
