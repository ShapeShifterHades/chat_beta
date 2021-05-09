import 'package:flutter/material.dart';
import 'package:void_chat_beta/data/utils/safe_print.dart';

class Switcher extends StatefulWidget {
  final Function? onChange;

  const Switcher({Key? key, this.onChange}) : super(key: key);
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isSwitched,
      onChanged: (value) {
        setState(() {
          isSwitched = value;
          widget.onChange!();
          safePrint('$isSwitched');
        });
      },
      activeTrackColor: Theme.of(context).primaryColor.withOpacity(0.65),
      activeColor: Theme.of(context).primaryColor,
    );
  }
}
