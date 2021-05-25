import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class FormHeaderSignUp extends StatefulWidget {
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
  _FormHeaderSignUpState createState() => _FormHeaderSignUpState();
}

class _FormHeaderSignUpState extends State<FormHeaderSignUp>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    rotationController =
        AnimationController(duration: Times.slower, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: double.infinity,
      color: widget.color,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 34),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    widget.title,
                    style: TextStyles.body1.copyWith(
                      fontSize: 22,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  rotationController.status == AnimationStatus.completed
                      ? rotationController.reverse()
                      : rotationController.forward();
                  if (widget.formController!.value == 1.0) {
                    await widget.formController!
                        .playReverse(duration: Times.medium);
                    await widget.settingsController!
                        .play(duration: Times.medium);
                  } else {
                    await widget.settingsController!
                        .playReverse(duration: Times.medium);
                    await widget.formController!.play(duration: Times.medium);
                  }
                },
                child: RotationTransition(
                  turns:
                      Tween(begin: 0.0, end: 1.0).animate(rotationController),
                  child: FaIcon(
                    FontAwesomeIcons.cog,
                    color: Theme.of(context).backgroundColor,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: 14),
            ],
          ),
          const SizedBox(height: 1),
        ],
      ),
    );
  }
}
