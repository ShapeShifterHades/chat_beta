import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';

class UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (username) =>
              context.read<SignUpCubit>().usernameChanged(username),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'username',
            helperText: '',
            errorText: state.username.invalid ? 'invalid username' : null,
          ),
        );
      },
    );
  }
}
