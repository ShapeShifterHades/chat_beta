import 'package:flutter/material.dart';

import '../portrait_mobile_ui.dart';

class ChatlistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PortraitMobileUI(
        routeName: 'Messages',
        content: Container(
          child: Text(
            ModalRoute.of(context).settings.name ?? 'messages route',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
      ),
    );
  }
}
