import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:get/get.dart';

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
          style: GoogleFonts.jura(fontSize: 24),
          decoration: InputDecoration(
            labelText: 'loginpage_password'.tr,
            helperText: '',
            errorText:
                state.password.invalid ? 'loginpage_invalid_password'.tr : null,
          ),
        );
      },
    );
  }
}
