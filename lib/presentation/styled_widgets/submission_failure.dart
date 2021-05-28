import 'package:flutter/material.dart';
import 'package:void_chat_beta/presentation/animated_widgets/animated_error_message.dart';
import 'package:void_chat_beta/presentation/styled_widgets/submit_ready_button.dart';

class SubmissionFailure extends StatelessWidget {
  final String? submitErrorMessage;

  const SubmissionFailure({
    Key? key,
    this.submitErrorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedErrorMessage(submitErrorMessage: submitErrorMessage),
        const SubmitReadyButton(key: Key('login_submit_after_error_button')),
      ],
    );
  }
}
