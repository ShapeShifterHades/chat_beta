import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';
import 'package:void_chat_beta/presentation/animated_widgets/submission_in_progress_button.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return SubmissionInProgressButton(
            color: Theme.of(context).primaryColor,
            //TODO: make it from S.delegate
            text: 'CONNECTING',
          );
        }
        if (state.status == FormzStatus.submissionFailure) {
          return const SubmissionFailure(key: Key('login_submit_fail_button'));
        }
        return const SubmitButton(key: Key('login_submit_button'));
      },
    );
  }
}

class SubmissionFailure extends StatelessWidget {
  const SubmissionFailure({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _AnimatedErrorMessage(),
        SubmitButton(key: Key('login_submit_after_error_button')),
      ],
    );
  }
}

class _AnimatedErrorMessage extends StatefulWidget {
  const _AnimatedErrorMessage({
    Key? key,
  }) : super(key: key);

  @override
  __AnimatedErrorMessageState createState() => __AnimatedErrorMessageState();
}

class __AnimatedErrorMessageState extends State<_AnimatedErrorMessage>
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
                'Error, please check your credentials',
                style: TextStyles.body3
                    .copyWith(color: Theme.of(context).backgroundColor),
              ),
            ),
          );
        });
  }
}

class SubmitButton extends StatelessWidget {
  final String? text;
  final VoidCallback? func;
  const SubmitButton({
    Key? key,
    this.text,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isValid = context.watch<LoginCubit>().state.status.isValidated;
    return GestureDetector(
      onTap: func ??
          (_isValid
              ? () {
                  context.read<LoginCubit>().logInWithCredentials();
                }
              : null),
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 54,
        padding: const EdgeInsets.only(bottom: 10),
        color: Theme.of(context).primaryColor,
        child: Text(text ?? S.of(context).loginpage_submit,
            style: TextStyles.body1
                .copyWith(color: Theme.of(context).backgroundColor)),
      ),
    );
  }
}

class StyledLoadSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.5),
          valueColor:
              AlwaysStoppedAnimation<Color>(Theme.of(context).backgroundColor),
        ));
  }
}
