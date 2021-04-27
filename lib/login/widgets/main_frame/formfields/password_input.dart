import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          style: TextStyles.body2,
          decoration: InputDecoration(
            fillColor: Theme.of(context).backgroundColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.3,
                color: Theme.of(context).primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.3,
                color: Theme.of(context).primaryColor,
              ),
            ),
            labelText: S.of(context)!.loginpage_password,
            helperText: '',
            errorText: state.password.invalid
                ? S.of(context)!.loginpage_invalid_password
                : null,
          ),
        );
      },
    );
  }
}
