import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class ConfirmPasswordInput extends StatelessWidget {
  ConfirmPasswordInput({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
        builder: (context, state) {
          return TextField(
            style: TextStyles.body1,
            cursorColor: Theme.of(context).primaryColor,
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) => context
                .read<SignUpCubit>()
                .confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            decoration: InputDecoration(
              labelText: S.of(context).signup_confirm_password,
              helperText: '',
              errorText: state.confirmedPassword.invalid
                  ? S.of(context).signup_invalid_confirm_password
                  : null,
            ),
          );
        },
      ),
    );
  }
}
