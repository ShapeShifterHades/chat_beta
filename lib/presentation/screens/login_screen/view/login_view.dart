import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/main_frame/login_main_form_frame.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/svg_background.dart';
import 'package:void_chat_beta/presentation/screens/login_screen/widgets/switch_to_signup_button.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/signup_form_frame.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SignUpCubit(
              RepositoryProvider.of<AuthenticationRepository>(context),
              RepositoryProvider.of<FirestoreNewUserRepository>(context),
            ),
        child: BlocProvider<LoginCubit>(
          create: (context) =>
              LoginCubit(context.read<AuthenticationRepository>()),
          child: KeyboardVisibilityProvider(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  const SvgBackground(),
                  AnimatedSwitcher(
                      duration: Times.medium,
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: isLogin
                          ? const LoginMainFormFrame(
                              key: ValueKey('login_main_form_frame'),
                            )
                          : const SignupMainFormFrame(
                              key: ValueKey('signup_main_form_frame'),
                            )),
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                      child: LoginSwitchButton(trigger: isLogin),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
