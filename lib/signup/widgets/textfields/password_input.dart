import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:get/get.dart';

class PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          style: GoogleFonts.jura(fontSize: 24),
          cursorColor: Theme.of(context).primaryColor,
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'signup_password'.tr,
            helperText: '',
            errorText:
                state.password.invalid ? 'signup_invalid_password'.tr : null,
          ),
        );
      },
    );
  }
}
