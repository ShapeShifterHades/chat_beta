import 'package:flutter/material.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/frontside/minimenu/toggle_drawer_button.dart';

import 'drawer/drawer.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

import 'frontside/app_content.dart';
import 'frontside/minimenu/mini_menu.dart';

/// [UI] class combines drawer and slidable content side of UI after user is logged in
class UI extends StatefulWidget {
  // content is a Widget, passed to PortraitMobileUI that is a current page's materials
  final Widget body;
  final Widget? statusBar;

  const UI({
    Key? key,
    required this.body,
    this.statusBar,
  }) : super(key: key);

  static UIState? of(BuildContext context) =>
      context.findAncestorStateOfType<UIState>();

  @override
  UIState createState() => new UIState();
}

class UIState extends State<UI> with SingleTickerProviderStateMixin {
  // Length of the drawer slide
  static const double maxSlide = 170;
  // Minimum edge where slider starts animating
  static const double minDragStartEdge = 170;
  // On what distance it needs to be dragged
  static double maxDragStartEdge = maxSlide - 16;
  AnimationController? _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Times.medium,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (_animationController!.isCompleted) {
            close();
            return false;
          }
          return true;
        },
        child: AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) {
            final slideAmount = maxSlide * _animationController!.value;
            // This stack defines relations between drawer side and content side
            return Stack(
              children: <Widget>[
                DrawerBack(),
                Transform(
                  transform: Matrix4.identity()..translate(slideAmount),
                  alignment: Alignment.centerLeft,
                  child: child!,
                ),
              ],
            );
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: _animationController!.isCompleted ? close : null,
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                  child: AppContent(child: widget.body),
                ),
              ),
              MiniMenu(),
              ToggleDrawerButton(animationController: _animationController),
            ],
          ),
        ),
      ),
    );
  }

  /// Closes drawer
  void close() => _animationController!.reverse();

  /// Opens drawer
  void open() => _animationController!.forward();

  /// Handles gesture drawer control starting drawer animation
  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController!.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = _animationController!.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  /// Handles gesture drawer control continuing drawer animation

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController!.value += delta;
    }
  }

  /// Handles gesture drawer control ending drawer animation

  void _onDragEnd(DragEndDetails details) {
    double _kMinFlingVelocity = 365.0;

    if (_animationController!.isDismissed ||
        _animationController!.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      _animationController!.fling(velocity: visualVelocity);
    } else if (_animationController!.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}
