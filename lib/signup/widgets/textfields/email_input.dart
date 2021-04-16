import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/styles.dart';

class EmailInput extends StatelessWidget {
  EmailInput({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          style: TextStyles.body1,
          cursorColor: Theme.of(context).primaryColor,
          key: const Key('signUpForm_emailInput_textField'),
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'signup_email'.tr,
            helperText: '',
            errorText: state.email.invalid ? 'signup_invalid_email'.tr : null,
          ),
        );
      },
    );
  }
}
