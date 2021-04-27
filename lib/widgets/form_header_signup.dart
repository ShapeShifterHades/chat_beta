import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/styles.dart';

class FormHeaderSignUp extends StatelessWidget {
  final Color color;
  final String title;
  final AnimationController? formController;
  final AnimationController? settingsController;

  const FormHeaderSignUp({
    Key? key,
    required this.color,
    required this.title,
    this.formController,
    this.settingsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
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
              SizedBox(width: 34),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    title,
                    style: TextStyles.body1.copyWith(
                      fontSize: 22,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formController!.value == 1.0) {
                    await formController!.playReverse(duration: Times.fast);
                    await settingsController!.play(duration: Times.fast);
                  } else {
                    await settingsController!.playReverse(duration: Times.fast);
                    await formController!.play(duration: Times.fast);
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
          SizedBox(height: 1),
        ],
      ),
    );
  }
}
