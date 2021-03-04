import 'package:flutter/material.dart';
import 'package:void_chat_beta/ui/ui.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UI(
        body: Container(
          child: Text(
            ModalRoute.of(context).settings.name ?? 'settings route',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
