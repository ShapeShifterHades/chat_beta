import 'package:flutter/material.dart';
import 'package:void_chat_beta/ui/ui.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UI(
        body: Container(
          child: Text(
            ModalRoute.of(context)!.settings.name ?? 'faq route',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
