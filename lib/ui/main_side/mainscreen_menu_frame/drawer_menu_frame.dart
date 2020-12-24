import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'menu_button_pm.dart';
import 'screen_tag.dart';

// ignore: must_be_immutable
class DrawerMenuFrame extends StatefulWidget {
  AnimationController animationController;
  String routeName;
  Widget child;
  DrawerMenuFrame({
    Key key,
    this.animationController,
    this.child,
    this.routeName,
  }) : super(key: key);

  @override
  _DrawerMenuFrameState createState() => _DrawerMenuFrameState();
}

class _DrawerMenuFrameState extends State<DrawerMenuFrame>
    with TickerProviderStateMixin {
  AnimationController _frameController;
  Animation<double> _frameAnimation;

  @override
  void initState() {
    super.initState();
    _frameController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _frameAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_frameController);
  }

  @override
  void dispose() {
    _frameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    _frameController.forward();
    return FadeTransition(
      opacity: _frameAnimation,
      child: Column(
        children: [
          Container(
            width: size.width * 0.9,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MenuButtonPM(animationController: widget.animationController),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: ScreenTag(routeName: widget.routeName),
                ),
                SizedBox(width: 0),
                Material(
                  color: Colors.transparent,
                  child: Container(
                    child: IconButton(
                        padding: EdgeInsets.only(top: 4, right: 4),
                        icon: FaIcon(
                          FontAwesomeIcons.solidEnvelope,
                          color: Colors.grey,
                          size: 28,
                        ),
                        onPressed: () {
                          print("Pressed");
                        }),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              color: Colors.amber,
              width: size.width * 0.8,
              height: size.height - size.width * 0.1 - 130,
              child: Scaffold(
                body: widget.child,
              ))
        ],
      ),
    );
  }
}
