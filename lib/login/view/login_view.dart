import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/main_frame/login_main_form_frame.dart';
import 'package:void_chat_beta/login/widgets/switch_to_signup_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocProvider(
      create: (context) => LoginCubit(context.read<AuthenticationRepository>()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SvgPicture.asset(
              isDark
                  ? 'assets/images/bg-dark.svg'
                  : 'assets/images/bg-light.svg',
              fit: BoxFit.fill,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            LoginMainFormFrame(),
            SwitchToSignUpButton(),
          ],
        ),
      ),
    );
  }
}
