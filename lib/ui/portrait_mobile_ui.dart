import 'package:flutter/material.dart';

import 'drawer_side/portrait_mobile_drawer/portrait_mobile_drawer.dart';
import 'main_side/frame/animated_frame/portrait/custom_full_frame_animated.dart';
import 'main_side/upside_menu/upside_menu.dart';

class PortraitMobileUI extends StatefulWidget {
  /// [PortraitMobileUI] class combines drawer and slidable content side of UI after user is logged in
  // content is a Widget, passed to PortraitMobileUI that is a current page's materials
  final Widget content;
  // This variable is deprecated and to be deleted from here
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
  static const double maxSlide = 256;
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
          child: Container(
            color: Theme.of(context).backgroundColor,
            margin: EdgeInsets.fromLTRB(
              size.width * 0.05,
              size.width * 0.05 + 30,
              size.width * 0.01,
              size.width * 0.01,
            ),
            child: CustomFullFrameAnimated(
              context: context,
              size: size,
            ),
          ),
          builder: (context, child) {
            double animValue = _animationController.value;
            final slideAmount = maxSlide * animValue;
            return Stack(
              overflow: Overflow.clip,
              children: <Widget>[
                DrawerPM(),
                Transform(
                  transform: Matrix4.identity()..translate(slideAmount),
                  alignment: Alignment.centerLeft,
                  child: Stack(
                    overflow: Overflow.clip,
                    children: [
                      child,
                      Positioned(
                        left: size.width * 0.05,
                        top: size.width * 0.05 + 30,
                        child: GestureDetector(
                          // This Gestures closes [DrawerPM] when it is opened
                          onTap:
                              _animationController.isCompleted ? close : null,
                          onHorizontalDragStart: _onDragStart,
                          onHorizontalDragUpdate: _onDragUpdate,
                          onHorizontalDragEnd: _onDragEnd,
                          child: UpsideMenu(
                              routeName: widget.routeName,
                              animationController: _animationController),
                        ),
                      ),
                      Positioned(
                        // This is where main page content's scaffold size is defined
                        top: size.width * 0.05 + 80,
                        left: size.width * 0.05 + 10,
                        right: size.width * 0.05 + 10,
                        bottom: size.width * 0.05 + 70,
                        child: GestureDetector(
                            // This Gestures closes [DrawerPM] when it is opened
                            onTap:
                                _animationController.isCompleted ? close : null,
                            onHorizontalDragStart: _onDragStart,
                            onHorizontalDragUpdate: _onDragUpdate,
                            onHorizontalDragEnd: _onDragEnd,
                            child: widget.content),
                      ),
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
