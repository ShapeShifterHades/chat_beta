import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:void_chat_beta/signup/widgets/signup_form.dart';
import 'package:void_chat_beta/ui/main_side/frame/animated_frame/portrait/custom_full_frame_animated.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const SignUpPage());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<SignUpCubit>(
            create: (_) => SignUpCubit(
              context.read<AuthenticationRepository>(),
              context.read<FirestoreNewUserRepository>(),
            ),
          ),
        ],
        child: SignUpForm(),
      ),
    );
  }
}
