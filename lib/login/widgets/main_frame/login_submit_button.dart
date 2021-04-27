import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/generated/l10n.dart';

import 'button_model.dart';

class LoginSubmitButton extends StatelessWidget {
  const LoginSubmitButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return PhysicalModel(
          shadowColor: Colors.red,
          color: Colors.white,
          elevation: 3,
          child: Container(
            child: ButtonModel(
              key: const Key('loginForm_continue_raisedButton'),
              text: S.of(context).loginpage_submit,
              onPressed: state.status.isValidated
                  ? () => context.read<LoginCubit>().logInWithCredentials()
                  : null,
            ),
          ),
        );
      },
    );
  }
}
