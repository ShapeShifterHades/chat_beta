import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class AnimatedErrorMessage extends StatefulWidget {
  final String? submitErrorMessage;

  const AnimatedErrorMessage({
    Key? key,
    this.submitErrorMessage,
  }) : super(key: key);

  @override
  __AnimatedErrorMessageState createState() => __AnimatedErrorMessageState();
}

class __AnimatedErrorMessageState extends State<AnimatedErrorMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    animationController =
        AnimationController(duration: Times.fast, vsync: this);
    animation = animationController;
    super.initState();
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Container(
            color: Colors.red,
            width: double.infinity,
            height: 27 * animation.value,
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 3.0),
              child: Text(
                widget.submitErrorMessage ??
                    'Error, please check your credentials',
                style: TextStyles.body3
                    .copyWith(color: Theme.of(context).backgroundColor),
              ),
            ),
          );
        });
  }
}
