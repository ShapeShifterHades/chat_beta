import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'drawer/drawer.dart';

import './frontside/status_bar/status_bar.dart';
import 'frontside/frame/animated_frame/ui_frame_animated.dart';
import 'frontside/minimenu/mini_menu.dart';

/// [UI] class combines drawer and slidable content side of UI after user is logged in
class UI extends StatefulWidget {
  // content is a Widget, passed to PortraitMobileUI that is a current page's materials
  final Widget body;
  final Widget statusBar;

  const UI({
    Key key,
    @required this.body,
    this.statusBar,
  }) : super(key: key);

  static UIState of(BuildContext context) =>
      context.findAncestorStateOfType<UIState>();

  @override
  UIState createState() => new UIState();
}

class UIState extends State<UI> with SingleTickerProviderStateMixin {
  // Duraton of drawer slide
  static const Duration toggleDuration = Duration(milliseconds: 400);
  // Length of the drawer
  static const double maxSlide = 170;
  // Minimum edge where slider starts animating
  static const double minDragStartEdge = 100;
  // On what distance it needs to be dragged
  static double maxDragStartEdge = maxSlide - 16;
  AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: UIState.toggleDuration,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
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
          // Here starts frontside of drawer-content system, margin defines its base shape
          child: Stack(
            // overflow: Overflow.clip,
            children: [
              Positioned.fill(
                child: Container(
                  color: Theme.of(context).backgroundColor,
                  margin: EdgeInsets.only(
                    left: size.width * 0.07,
                    top: size.width * 0.05 + 30,
                  ),

                  // Animated frame of main content part of UI
                  child: UiFullFrameAnimated(context: context, size: size),
                ),
              ),
              Positioned(
                // This is where main page content's scaffold size is defined
                top: size.width * 0.05 + 30,
                left: size.width * 0.05,
                right: 12,
                bottom: 00,
                child: Container(
                  // color: Colors.brown.withOpacity(0.1),
                  child: GestureDetector(
                      // This Gestures closes [DrawerPM] when it is opened
                      onTap: _animationController.isCompleted ? close : null,
                      onHorizontalDragStart: _onDragStart,
                      onHorizontalDragUpdate: _onDragUpdate,
                      onHorizontalDragEnd: _onDragEnd,
                      // Here is the content of the pages
                      child: widget.body),
                ),
              ),
              // MiniMenu
              MiniMenu(size: size),
            ],
          ),
          builder: (context, child) {
            double animValue = _animationController.value;
            final slideAmount = maxSlide * animValue;
            // This stack defines relations between drawer side and content side
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
                          child: widget.statusBar ??
                              StatusBar(
                                  animationController: _animationController),
                        ),
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

  /// Closes drawer
  void close() => _animationController.reverse();

  /// Opens drawer
  void open() => _animationController.forward();

  /// Handles gesture drawer control starting drawer animation
  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  /// Handles gesture drawer control continuing drawer animation

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      _animationController.value += delta;
    }
  }

  /// Handles gesture drawer control ending drawer animation

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
