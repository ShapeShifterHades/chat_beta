import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/router/app_router.dart';
import 'package:void_chat_beta/sqflite/bloc/contact_bloc.dart';
import 'package:void_chat_beta/theme.dart';
import 'authentication/authentication.dart';
import 'sqflite/repository/contact_repository.dart';

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
            child: AppView(),
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
    return MaterialApp(
      theme: theme1(context),
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushNamedAndRemoveUntil<void>('/', (route) => false);
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushNamedAndRemoveUntil<void>(
                  '/login',
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }

  @override
  void dispose() {
    _appRouter.dispose();
    super.dispose();
  }
}
