import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:get/get.dart';
import 'package:formz/formz.dart';

import 'button_model.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return ButtonModel(
          key: const Key('loginForm_continue_raisedButton'),
          text: 'loginpage_submit'.tr,
          onPressed: state.status.isValidated
              ? () => context.read<LoginCubit>().logInWithCredentials()
              : null,
        );
      },
    );
  }
}
