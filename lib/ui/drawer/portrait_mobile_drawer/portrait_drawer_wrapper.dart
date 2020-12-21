import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants/constants.dart';

import 'menu_frame/drawer_menu_frame.dart';

class PortraitDrawerWrapper extends StatefulWidget {
  final Widget child;

  const PortraitDrawerWrapper({Key key, @required this.child})
      : super(key: key);

  static PortraitDrawerWrapperState of(BuildContext context) =>
      context.findAncestorStateOfType<PortraitDrawerWrapperState>();

  @override
  PortraitDrawerWrapperState createState() => new PortraitDrawerWrapperState();
}

class PortraitDrawerWrapperState extends State<PortraitDrawerWrapper>
    with SingleTickerProviderStateMixin {
  static const Duration toggleDuration = Duration(milliseconds: 250);
  static const double maxSlide = 225;
  static const double minDragStartEdge = 100;
  static const double maxDragStartEdge = maxSlide - 16;
  AnimationController _animationController;
  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: PortraitDrawerWrapperState.toggleDuration,
    );
  }

  void close() => _animationController.reverse();

  void open() => _animationController.forward();

  void toggleDrawer() => _animationController.isCompleted ? close() : open();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: widget.child,
          builder: (context, child) {
            double animValue = _animationController.value;
            final slideAmount = maxSlide * animValue;
            return Stack(
              children: <Widget>[
                MyDrawer(),
                Transform(
                  transform: Matrix4.identity()..translate(slideAmount),
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: _animationController.isCompleted ? close : null,
                    child: Stack(
                      children: [
                        child,
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.05,
                          top: MediaQuery.of(context).size.width * 0.05 + 30,
                          child: GestureDetector(
                            onTap:
                                _animationController.isCompleted ? close : open,
                            onHorizontalDragStart: _onDragStart,
                            onHorizontalDragUpdate: _onDragUpdate,
                            onHorizontalDragEnd: _onDragEnd,
                            child: DrawerMenuFrame(
                                controller: _animationController),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

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

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kMainBgColor,
      child: SafeArea(
        child: Theme(
          data: ThemeData(brightness: Brightness.dark),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ListTile(
                leading: Icon(Icons.new_releases),
                title: Text('News'),
              ),
              ListTile(
                leading: Icon(Icons.star),
                title: Text('Favourites'),
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('Map'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
