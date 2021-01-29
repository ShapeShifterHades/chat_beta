import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen_tag.dart';
import 'toggle_drawer_button.dart';

// ignore: must_be_immutable
class StatusBar extends StatefulWidget {
  AnimationController animationController;

  StatusBar({
    Key key,
    this.animationController,
  }) : super(key: key);

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> with TickerProviderStateMixin {
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
                ToggleDrawerButton(
                    animationController: widget.animationController),
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 4),
                  child: ScreenTag(
                    context: context,
                  ),
                ),
                SizedBox(width: 0),
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 4, left: 4),
                      child: IconButton(
                          padding: EdgeInsets.only(top: 4, right: 4),
                          icon: FaIcon(
                            FontAwesomeIcons.solidEnvelope,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                            size: 28,
                          ),
                          onPressed: () {
                            print("New messages button was pressed");
                          }),
                    ),
                    Positioned(
                      bottom: 2,
                      right: 2,
                      child: Container(
                        width: 22,
                        height: 15,
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            width: 1,
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.7),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            '23',
                            textAlign: TextAlign.right,
                            style: GoogleFonts.jura(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
