import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/styles.dart';

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
            labelText: 'loginpage_email'.tr,
            helperText: '',
            errorText:
                state.email.invalid ? 'loginpage_invalid_email'.tr : null,
          ),
        );
      },
    );
  }
}
