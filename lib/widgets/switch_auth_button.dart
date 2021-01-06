import 'package:flutter/material.dart';

class SwitchAuthButton extends StatefulWidget {
  const SwitchAuthButton({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  _SwitchAuthButtonState createState() => _SwitchAuthButtonState();
}

class _SwitchAuthButtonState extends State<SwitchAuthButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 4000),
        vsync: this,
        value: 0.2,
        lowerBound: 0.2,
        upperBound: 0.8);
    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _controller.forward();
            }
          });
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(width: 2),
          Text(
            widget.text,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 12,
            ),
          ),
          Icon(
            Icons.double_arrow,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
