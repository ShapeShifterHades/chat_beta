import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      ModalRoute.of(context)!.settings.name ?? 'settings route',
      style: const TextStyle(color: Colors.white),
    );
  }
}
