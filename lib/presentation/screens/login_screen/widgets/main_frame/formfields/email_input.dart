import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';

class EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          cursorColor: Theme.of(context).primaryColor,
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
            labelText: S.of(context).loginpage_email,
            helperText: '',
            errorText: state.email.invalid
                ? S.of(context).loginpage_invalid_email
                : null,
          ),
        );
      },
    );
  }
}
