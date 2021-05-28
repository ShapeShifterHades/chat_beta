import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/presentation/styled_widgets/styled_load_spinner.dart';

class SubmissionInProgressButton extends StatefulWidget {
  final Color color;
  final String? text;
  const SubmissionInProgressButton({
    Key? key,
    required this.color,
    this.text,
  }) : super(key: key);

  @override
  _SubmissionInProgressButtonState createState() =>
      _SubmissionInProgressButtonState();
}

class _SubmissionInProgressButtonState extends State<SubmissionInProgressButton>
    with TickerProviderStateMixin {
  late AnimationController controller1;
  late AnimationController controller2;
  late AnimationController controller3;
  late AnimationController controller4;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller1 = AnimationController(vsync: this, duration: Times.slower);
    controller2 = AnimationController(vsync: this, duration: Times.slower);
    controller3 = AnimationController(vsync: this, duration: Times.slower);
    controller4 = AnimationController(vsync: this, duration: Times.slower);
    animation = controller1
      ..addListener(() {
        setState(() {});
      });
    setUpAnimation(controller1, 0);
    setUpAnimation(controller2, 250);
    setUpAnimation(controller3, 500);
    setUpAnimation(controller4, 750);
  }

  void setUpAnimation(AnimationController controller, int delay,
      {Duration duration = Times.slower}) {
    Future.delayed(Duration(milliseconds: delay), () {
      if (mounted) {
        controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          color: widget.color,
          width: double.infinity,
          alignment: Alignment.center,
          height: 54,
          child: Row(
            children: [
              const Spacer(flex: 6),
              Opacity(
                opacity: controller1.value,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              Opacity(
                opacity: controller2.value,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              const Spacer(),
              if (widget.text == null)
                StyledLoadSpinner()
              else
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(widget.text!,
                      style: TextStyles.body1
                          .copyWith(color: Theme.of(context).backgroundColor)),
                ),
              const Spacer(),
              Opacity(
                opacity: controller3.value,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              Opacity(
                opacity: controller4.value,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).backgroundColor,
                ),
              ),
              const Spacer(flex: 6),
            ],
          ),
        );
      },
    );
  }
}
