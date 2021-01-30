import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screen_tag.dart';
import 'toggle_drawer_button.dart';

// ignore: must_be_immutable
class StatusBar extends StatelessWidget {
  AnimationController animationController;

  StatusBar({
    Key key,
    this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: size.width * 0.9,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ToggleDrawerButton(animationController: animationController),
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
                          size: 24,
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
                          width: 0.3,
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
                            fontWeight: FontWeight.w300,
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
    );
  }
}
