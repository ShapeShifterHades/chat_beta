import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';

class PortraitMobileDrawer extends StatefulWidget {
  PortraitMobileDrawer({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  _PortraitMobileDrawerState createState() => _PortraitMobileDrawerState();
}

class _PortraitMobileDrawerState extends State<PortraitMobileDrawer>
    with TickerProviderStateMixin {
  Animation<double> _drawerAnimation;
  Tween<double> _drawerTween;
  AnimationController controller;

  static const double maxSlide = 225;
  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _drawerTween = Tween(begin: -widget.size.width * 0.45, end: 0);
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _drawerAnimation = _drawerTween.animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(0.0, 1),
      ),
    );
  }

  void close() => controller.reverse();

  void open() => controller.forward();

  void toggleDrawer() {
    if (_drawerAnimation.isCompleted) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft =
        controller.isDismissed && details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight =
        controller.isCompleted && details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta / maxSlide;
      controller.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (controller.isDismissed || controller.isCompleted) return;
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      controller.fling(velocity: visualVelocity);
    } else if (controller.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _drawerAnimation,
      builder: (context, child) {
        return Positioned(
          left: _drawerAnimation.value,
          child: Container(
            height: widget.size.height,
            width: widget.size.width / 2,
            color: kMainBgColor,
            child: Row(
              children: [
                Container(
                  width: widget.size.width / 2 - widget.size.width * 0.05 + 1,
                  child: Column(),
                ),
                GestureDetector(
                  onHorizontalDragStart: _onDragStart,
                  onHorizontalDragUpdate: _onDragUpdate,
                  onHorizontalDragEnd: _onDragEnd,
                  onTap: () {
                    toggleDrawer();
                  },
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      verticalDirection: VerticalDirection.up,
                      children: [
                        SizedBox(height: widget.size.width * 0.05),
                        Container(
                          height:
                              widget.size.height - widget.size.width * 0.1 - 30,
                          width: widget.size.width * 0.05 - 1,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                width: 0.5,
                                color: kMainTextColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: widget.size.width * 0.05),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },

      // left: size.width / 2 - size.width * 0.95 - 1,
    );
  }
}
