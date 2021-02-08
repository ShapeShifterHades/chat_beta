import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/login/cubit/login_cubit.dart';
import 'package:void_chat_beta/login/widgets/login_form.dart';
import '../../theme/brightness_cubit.dart';
import '../../theme/locale_cubit.dart';

class LoginView extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => LoginView());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 40),
          FloatingActionButton(
            key: Key('rightButton'),
            child: const Icon(Icons.brightness_6),
            onPressed: () {
              context.read<LocaleCubit>().toggleLocale();
              print(context.read<LocaleCubit>().state ??
                  Get.deviceLocale.countryCode);
              Get.updateLocale(Locale(context.read<LocaleCubit>().state));
              context.read<BrightnessCubit>().toggleBrightness();
              Get.toNamed('/newSignUp');
            },
          ),
        ],
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
