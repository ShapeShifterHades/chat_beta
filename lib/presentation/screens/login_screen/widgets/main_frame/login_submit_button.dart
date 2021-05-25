import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';

import 'button_model.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return _SubmissionInProgressButton(
            startColor: Theme.of(context).primaryColor,
            endColor: Color(0xffffeb3b),
            //TODO: make it from S.delegate
            text: 'Sending',
          );
        }
        if (state.status == FormzStatus.submissionFailure) {
          return _InitialButton();
        }
        return const _InitialButton();
      },
    );
  }
}

class _SubmissionInProgressButton extends StatefulWidget {
  final Color startColor;
  final Color endColor;
  final String text;
  const _SubmissionInProgressButton({
    Key? key,
    required this.startColor,
    required this.endColor,
    required this.text,
  }) : super(key: key);

  @override
  __SubmissionInProgressButtonState createState() =>
      __SubmissionInProgressButtonState();
}

class __SubmissionInProgressButtonState
    extends State<_SubmissionInProgressButton> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _controller.forward();
  }

  void _initAnimation() {
    _controller = AnimationController(duration: Times.medium, vsync: this);
    _colorAnimation = Tween<Color>(
            begin: widget.startColor, end: widget.endColor)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool _isValid = context.read<LoginCubit>().state.status.isValidated;
    return GestureDetector(
      onTap: _isValid
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
      child: AnimatedBuilder(
          animation: _colorAnimation,
          builder: (context, child) {
            return Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 54,
              padding: const EdgeInsets.only(bottom: 10),
              color: _colorAnimation.value,
              child: Text(widget.text,
                  style: TextStyles.body1
                      .copyWith(color: Theme.of(context).backgroundColor)),
            );
          }),
    );
  }
}

class _InitialButton extends StatelessWidget {
  const _InitialButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool _isValid = context.read<LoginCubit>().state.status.isValidated;
    return ButtonModel(
      key: const Key('loginForm_continue_raisedButton'),
      text: S.of(context).loginpage_submit,
      onPressed: _isValid
          ? () => context.read<LoginCubit>().logInWithCredentials()
          : null,
    );
  }
}
