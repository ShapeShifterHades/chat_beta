import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/frontside/minimenu/toggle_drawer_button.dart';

import 'drawer/drawer.dart';
import 'frontside/app_content.dart';
import 'frontside/minimenu/mini_menu.dart';

/// [UI] class combines drawer and slidable content side of UI after user is logged in
class UI extends StatefulWidget {
  // content is a Widget, passed to PortraitMobileUI that is a current page's materials
  final Widget body;

  const UI({
    Key? key,
    required this.body,
  }) : super(key: key);

  static UIState? of(BuildContext context) =>
      context.findAncestorStateOfType<UIState>();

  @override
  UIState createState() => UIState();
}

class UIState extends State<UI> with SingleTickerProviderStateMixin {
  // Length of the drawer slide
  static const double maxSlide = 170;
  // Minimum edge where slider starts animating
  static const double minDragStartEdge = 170;
  // On what distance it needs to be dragged
  static double maxDragStartEdge = maxSlide - 16;
  late AnimationController animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Times.medium,
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (animationController.isCompleted) {
            close();
            return false;
          }
          return true;
        },
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            final slideAmount = maxSlide * animationController.value;
            // This stack defines relations between drawer side and content side
            return Stack(
              children: <Widget>[
                DrawerBack(animationController: animationController),
                Transform(
                  transform: Matrix4.identity()..translate(slideAmount),
                  alignment: Alignment.centerLeft,
                  child: child,
                ),
              ],
            );
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: animationController.isCompleted ? close : null,
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                  child: AppContent(child: widget.body),
                ),
              ),
              const MiniMenu(),
              ToggleDrawerButton(animationController: animationController),
            ],
          ),
        ),
      ),
    );
  }

  /// Closes drawer
  void close() => animationController.reverse();

  /// Opens drawer
  void open() => animationController.forward();

  /// Handles gesture drawer control starting drawer animation
  void _onDragStart(DragStartDetails details) {
    final bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    final bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  /// Handles gesture drawer control continuing drawer animation

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      final double delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }

  /// Handles gesture drawer control ending drawer animation

  void _onDragEnd(DragEndDetails details) {
    const double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      final double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }
}
