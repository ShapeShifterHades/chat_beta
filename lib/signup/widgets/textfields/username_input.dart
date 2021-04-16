import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/styles.dart';

class UsernameInput extends StatelessWidget {
  UsernameInput({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
            labelText: 'signup_username'.tr,
            helperText: '',
            errorText:
                state.username.invalid ? 'signup_invalid_username'.tr : null,
          ),
        );
      },
    );
  }
}
