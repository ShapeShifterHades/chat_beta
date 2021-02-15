import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';

class FormHeaderSignUp extends StatelessWidget {
  final Color color;
  final String title;
  final AnimationController formController;
  final AnimationController settingsController;

  const FormHeaderSignUp({
    Key key,
    @required this.color,
    @required this.title,
    this.formController,
    this.settingsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: color,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.jura(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                      fontSize: 26,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formController.value == 1.0) {
                    await formController.playReverse();
                    await settingsController.play();
                  } else {
                    await settingsController.playReverse();
                    await formController.play();
                  }
                },
                child: Container(
                  child: FaIcon(
                    FontAwesomeIcons.cog,
                    color: Theme.of(context).backgroundColor,
                    size: 26,
                  ),
                ),
              ),
              SizedBox(width: 14),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     GestureDetector(
          //       onTap: () =>
          //           Navigator.of(context).pushNamed<void>(loginRoute),
          //       onPanUpdate: (details) {
          //         if (details.delta.dx > 0) {
          //           Navigator.of(context).pushNamed<void>(loginRoute);
          //         }
          //       },
          //       child: Container(
          //         height: 38,
          //         width: 220,
          //         alignment: Alignment.centerRight,
          //         decoration: BoxDecoration(
          //           color: Theme.of(context).backgroundColor,
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(14),
          //           ),
          //         ),
          //         child: SwitchAuthButton(
          //           text: 'signup_switch_to_login'.tr,
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 1),
          //   ],
          // ),
          SizedBox(height: 1),
        ],
      ),
    );
  }
}
