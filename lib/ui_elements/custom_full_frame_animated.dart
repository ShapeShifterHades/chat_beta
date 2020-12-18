import 'package:flutter/material.dart';

import 'custom_full_frame_painter.dart';

class CustomFullFrameAnimated extends StatefulWidget {
  const CustomFullFrameAnimated({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _PainterCustomWidgetTopState createState() => _PainterCustomWidgetTopState();
}

class _PainterCustomWidgetTopState extends State<CustomFullFrameAnimated>
    with TickerProviderStateMixin {
  Animation<double> _angleAnimation;

  Animation<double> _topAnimation;
  Animation<double> _botAnimation;
  Animation<double> _rightAnimation;
  Animation<double> _leftAnimation;
  AnimationController controller;
  Tween<double> _angleTween;

  Tween<double> _topTween;
  Tween<double> _botTween;
  Tween<double> _rightTween;
  Tween<double> _leftTween;

  Widget _buildAnimation(BuildContext ctx, Widget child) {
    return CustomPaint(
      painter: CustomFullFramePainter(
        animTopVal: _topAnimation.value,
        animrightVal: _rightAnimation.value,
        animBotVal: _botAnimation.value,
        animLeftVal: _leftAnimation.value,
        animAngle: _angleAnimation.value,
      ),
      child: Container(),
    );
  }

  @override
  void initState() {
    super.initState();
    _angleTween = Tween(begin: 0, end: 30);

    _topTween = Tween(begin: 0, end: widget.size.width * 0.9);
    _botTween = Tween(begin: 30, end: widget.size.width * 0.9);
    _leftTween =
        Tween(begin: 0, end: widget.size.height - widget.size.width * 0.1 - 30);
    _rightTween =
        Tween(begin: 0, end: widget.size.height - widget.size.width * 0.1 - 60);

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _angleAnimation = _angleTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.1),
      ),
    );
    _leftAnimation = _leftTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1),
      ),
    );
    _rightAnimation = _rightTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1),
      ),
    );
    _topAnimation = _topTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 0.5),
      ),
    );
    _botAnimation = _botTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.1, 0.5),
      ),
    )..addListener(() {
        setState(() {});
      });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => controller.forward().orCancel,
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext ctx) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
