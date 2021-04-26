import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class PasswordInput extends StatelessWidget {
  PasswordInput({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            style: TextStyles.body1,
            cursorColor: Theme.of(context).primaryColor,
            key: const Key('signUpForm_passwordInput_textField'),
            onChanged: (password) =>
                context.read<SignUpCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecoration(
              labelText: S.of(context).signup_password,
              helperText: '',
              errorText: state.password.invalid
                  ? S.of(context).loginpage_invalid_password
                  : null,
            ),
          );
        },
      ),
    );
  }
}
