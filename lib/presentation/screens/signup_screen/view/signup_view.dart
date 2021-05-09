import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/svg_background.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/main_form_frame.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/switch_to_login.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(
        RepositoryProvider.of<AuthenticationRepository?>(context),
        RepositoryProvider.of<FirestoreNewUserRepository?>(context),
      ),
      child: KeyboardVisibilityProvider(
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          resizeToAvoidBottomInset: false,
          body: Stack(children: const [
            SvgBackground(),
            SignupMainFormFrame(),
            SwitchToLogin(),
          ]),
        ),
      ),
    );
  }
}
