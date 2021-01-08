import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/login_form.dart';
import 'package:void_chat_beta/ui/main_side/frame/animated_frame/portrait/custom_full_frame_animated.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Stack(
        children: [
          Positioned(
              top: size.width * 0.05 + 30,
              bottom: size.width * 0.05,
              left: size.width * 0.05,
              right: size.width * 0.05,
              child: CustomFullFrameAnimated(
                size: size,
              )),
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    LoginCubit(context.read<AuthenticationRepository>()),
              ),
            ],
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
