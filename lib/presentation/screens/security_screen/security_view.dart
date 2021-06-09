import 'package:flutter/material.dart';

class SecurityView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      ModalRoute.of(context)!.settings.name ?? 'security route',
      style: const TextStyle(color: Colors.white),
    );
  }
}
