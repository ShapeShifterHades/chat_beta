import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';

class SubmitReadyButton extends StatelessWidget {
  final String? submitText;
  final VoidCallback? func;
  const SubmitReadyButton({
    Key? key,
    this.submitText,
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
        child: Text(submitText ?? S.of(context).loginpage_submit,
            style: TextStyles.body1
                .copyWith(color: Theme.of(context).backgroundColor)),
      ),
    );
  }
}
