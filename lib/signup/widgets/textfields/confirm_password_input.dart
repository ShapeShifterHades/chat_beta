import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/styles.dart';

class ConfirmPasswordInput extends StatelessWidget {
  ConfirmPasswordInput({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
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
            labelText: 'signup_confirm_password'.tr,
            helperText: '',
            errorText: state.confirmedPassword.invalid
                ? 'signup_invalid_confirm_password'.tr
                : null,
          ),
        );
      },
    );
  }
}
