import 'package:flutter/material.dart';
import 'toggle_drawer_button.dart';

// ignore: must_be_immutable
class StatusBar extends StatelessWidget {
  AnimationController animationController;

  StatusBar({
    Key key,
    this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.9,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ToggleDrawerButton(animationController: animationController),
              Spacer(),
            ],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
