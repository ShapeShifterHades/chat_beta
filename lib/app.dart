import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/login/translations/login.dart';
import 'package:void_chat_beta/router/app_router.dart';

import 'authentication/authentication.dart';
import 'contacts/bloc/contact_bloc.dart';
import 'package:sqflite_repository/sqflite_repository.dart';

import 'theme/brightness_cubit.dart';
import 'theme/theme.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    this.contactRepository,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final ContactRepository contactRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (context) => contactRepository,
      child: BlocProvider(
        create: (context) =>
            ContactBloc(contactRepository)..add(ContactLoaded()),
        child: RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
            child: BlocProvider(
                create: (context) => BrightnessCubit(), child: AppView()),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  final AppRouter _appRouter = AppRouter();
  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrightnessCubit, Brightness>(
      builder: (context, brightness) {
        return GetMaterialApp(
          translations: LoginPageTranslations(),
          locale: Get.deviceLocale,
          debugShowCheckedModeBanner: false,
          theme: theme1(context, brightness),
          // navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushNamedAndRemoveUntil<void>(
                        homeRoute, (route) => true);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushNamedAndRemoveUntil<void>(
                      loginRoute,
                      (route) => true,
                    );
                    break;
                  default:
                    break;
                }
                //                 switch (state.status) {
                //   case AuthenticationStatus.unauthenticated:
                //     _navigator.pushNamed(
                //       loginRoute,
                //     );
                //     break;
                //   case AuthenticationStatus.authenticated:
                //     _navigator.pushNamed(homeRoute);
                //     break;
                //   default:
                //     _navigator.pushNamedAndRemoveUntil<void>(
                //       loginRoute,
                //       (route) => false,
                //     );
                //     break;
                // }
              },
              child: child,
            );
          },
          onGenerateRoute: _appRouter.onGenerateRoute,
        );
      },
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
