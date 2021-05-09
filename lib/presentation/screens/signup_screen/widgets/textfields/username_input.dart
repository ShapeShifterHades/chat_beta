import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';

class UsernameInput extends StatelessWidget {
  const UsernameInput({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            style: TextStyles.body1,
            cursorColor: Theme.of(context).primaryColor,
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (username) =>
                context.read<SignUpCubit>().usernameChanged(username),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: S.of(context).signup_username,
              helperText: '',
              errorText: state.username.invalid
                  ? S.of(context).signup_invalid_username
                  : null,
            ),
          );
        },
      ),
    );
  }
}
