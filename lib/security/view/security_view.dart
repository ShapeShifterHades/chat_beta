import 'package:flutter/material.dart';
import 'package:void_chat_beta/ui/ui.dart';

class SecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UI(
        content: Container(
          child: Text(
            ModalRoute.of(context).settings.name ?? 'security route',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
