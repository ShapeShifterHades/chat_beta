import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';
import 'package:void_chat_beta/presentation/animated_widgets/submission_in_progress_button.dart';
import 'package:void_chat_beta/presentation/styled_widgets/submission_failure.dart';
import 'package:void_chat_beta/presentation/styled_widgets/submit_ready_button.dart';

class SignUpSubmitButton extends StatelessWidget {
  final String? submitText;
  final String? submissionInProgressText;
  final String? submitErrorMessage;
  final VoidCallback? func;
  const SignUpSubmitButton({
    Key? key,
    this.submitText,
    this.submissionInProgressText,
    this.submitErrorMessage,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return SubmissionInProgressButton(
            color: Theme.of(context).primaryColor,
            //TODO: make it from S.delegate
            text: submissionInProgressText ?? 'CONNECTING',
          );
        }
        if (state.status == FormzStatus.submissionFailure) {
          return const SubmissionFailure(key: Key('login_submit_fail_button'));
        }
        return SubmitReadyButton(
            func: func,
            key: const Key('login_submit_button'),
            submitText: submitText);
      },
    );
  }
}
