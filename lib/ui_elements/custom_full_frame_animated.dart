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
  Animation<double> _topAnimation;
  Animation<double> _rightAnimation;
  AnimationController controller;
  Tween<double> _topTween;
  Tween<double> _rightTween;

  Widget _buildAnimation(BuildContext ctx, Widget child) {
    return CustomPaint(
      painter: CustomFullFramePainter(
        animTopVal: _topAnimation.value,
        animrightVal: _rightAnimation.value,
      ),
      child: Container(),
    );
  }

  @override
  void initState() {
    super.initState();
    _topTween = Tween(begin: 0, end: widget.size.width * 0.9);
    _rightTween =
        Tween(begin: 0, end: widget.size.height - widget.size.width * 0.1 - 30);

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
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
    )..addListener(() {
        setState(() {});
      });
    // ..addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.repeat();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () => controller.forward().orCancel,
      );
    });
    // controller.forward();
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
