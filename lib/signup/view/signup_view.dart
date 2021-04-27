import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:void_chat_beta/signup/widgets/main_form_frame.dart';
import 'package:void_chat_beta/signup/widgets/switch_to_login.dart';
import 'package:void_chat_beta/widgets/svg_background.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        RepositoryProvider.of<AuthenticationRepository>(context),
        RepositoryProvider.of<FirestoreNewUserRepository>(context),
      ),
      child: KeyboardVisibilityProvider(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            SvgBackground(),
            SignupMainFormFrame(),
            SwitchToLogin(),
          ]),
        ),
      ),
    );
  }
}
