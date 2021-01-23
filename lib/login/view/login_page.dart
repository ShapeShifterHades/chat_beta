import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/login_form.dart';
import '../../theme/brightness_cubit.dart';

class LoginPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.brightness_6),
        onPressed: () {
          context.read<BrightnessCubit>().toggleBrightness();
        },
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                LoginCubit(context.read<AuthenticationRepository>()),
          ),
        ],
        child: LoginForm(),
      ),
    );
  }
}
