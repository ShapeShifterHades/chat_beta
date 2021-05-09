import 'package:flutter/material.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';

class SecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UI(
        body: Text(
          ModalRoute.of(context)!.settings.name ?? 'security route',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}