import 'package:flutter/material.dart';

class FaqView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      ModalRoute.of(context)!.settings.name ?? 'faq route',
      style: const TextStyle(color: Colors.white),
    );
  }
}
