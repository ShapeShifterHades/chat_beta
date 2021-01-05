import 'package:flutter/material.dart';

import 'drawer_side/portrait_mobile_drawer/portrait_mobile_drawer.dart';
import 'main_side/frame/animated_frame/portrait/custom_full_frame_animated.dart';
import 'main_side/upside_menu/upside_menu.dart';

class PortraitMobileUI extends StatefulWidget {
  final Widget content;
  final String routeName;

  const PortraitMobileUI({Key key, @required this.content, this.routeName})
      : super(key: key);

  static PortraitMobileUIState of(BuildContext context) =>
      context.findAncestorStateOfType<PortraitMobileUIState>();

  @override
  PortraitMobileUIState createState() => new PortraitMobileUIState();
}

class PortraitMobileUIState extends State<PortraitMobileUI>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 400);
  static const double maxSlide = 226;
  static const double minDragStartEdge = 100;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: PortraitMobileUIState.toggleDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (_animationController.isCompleted) {
          close();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        child: AnimatedBuilder(
          animation: _animationController,
          child: Stack(
            children: [
              Positioned(
                top: size.width * 0.05 + 30,
                bottom: size.width * 0.05,
                left: size.width * 0.05,
                right: size.width * 0.05,
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  child: CustomFullFrameAnimated(
                    size: size,
                  ),
                ),
              ),
            ],
          ),
          builder: (context, child) {
            double animValue = _animationController.value;
            final slideAmount = maxSlide * animValue;
            return Stack(
              children: <Widget>[
                DrawerPM(),
                Transform(
                  transform: Matrix4.identity()..translate(slideAmount),
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    children: [
                      child,
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.05,
                        top: MediaQuery.of(context).size.width * 0.05 + 30,
                        child: GestureDetector(
                          onTap:
                              _animationController.isCompleted ? close : null,
                          onHorizontalDragStart: _onDragStart,
                          onHorizontalDragUpdate: _onDragUpdate,
                          onHorizontalDragEnd: _onDragEnd,
                          child: UpsideMenu(
                              routeName: widget.routeName,
                              child: widget.content,
                              animationController: _animationController),
                        ),
                      ),
                      // Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Text(
                      //       _animationController.value.toString(),
                      //       style: TextStyle(color: Colors.white),
                      //     )),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}
