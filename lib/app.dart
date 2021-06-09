import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:void_chat_beta/core/themes/app_theme.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/dialogs/dialogs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contacts/contacts_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contacts_tabs/contacts_tabs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contacts_find_user/contacts_finduser_bloc.dart';
import 'package:void_chat_beta/logic/bloc/messages/messages_bloc.dart';
import 'package:void_chat_beta/logic/bloc/search_button/search_button_bloc.dart';
import 'package:void_chat_beta/logic/cubit/brightness/brightness.dart';
import 'package:void_chat_beta/logic/cubit/locale/locale.dart';

import 'package:void_chat_beta/presentation/screens/login_screen/login_view.dart';
import 'package:void_chat_beta/presentation/screens/main_screen/main_screen.dart';

import 'package:void_chat_beta/presentation/screens/splash_screen/splash_view.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<FirebaseStorageRepository>(
              create: (_) => FirebaseStorageRepository()),
          RepositoryProvider<AuthenticationRepository>(
              create: (_) => AuthenticationRepository()),
          RepositoryProvider<FirestoreContactRepository?>(
              create: (_) => FirestoreContactRepository()),
          RepositoryProvider<FirestoreHelperRepository>(
              create: (_) => FirestoreHelperRepository()),
          RepositoryProvider<FirestoreChatroomRepository?>(
              create: (_) => FirestoreChatroomRepository()),
          RepositoryProvider<FirestoreMessageRepository?>(
              create: (_) => FirestoreMessageRepository()),
        ],
        child: Builder(builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
              ),
            ),
            BlocProvider<LocaleCubit>(
              create: (context) => LocaleCubit(),
            ),
            BlocProvider<BrightnessCubit>(
              create: (context) => BrightnessCubit(),
            ),
          ], child: const AppView());
        }));
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return BlocBuilder<BrightnessCubit, Brightness>(
          builder: (context, brightness) {
            return AnnotatedRegion<SystemUiOverlayStyle>(
              value: BlocProvider.of<BrightnessCubit>(context).state ==
                      Brightness.dark
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light,
              child: BlocBuilder<LocaleCubit, String>(
                builder: (context, locale) {
                  final bool isDark =
                      BlocProvider.of<BrightnessCubit>(context).state ==
                          Brightness.dark;
                  return MaterialApp(
                    locale: Locale(context.read<LocaleCubit>().state),
                    initialRoute: '/',
                    onGenerateRoute: (RouteSettings settings) {
                      return MaterialPageRoute<dynamic>(
                        builder: (context) {
                          return BlocBuilder<AuthenticationBloc,
                              AuthenticationState>(
                            builder: (context, state) {
                              if (state.status ==
                                  AuthenticationStatus.unauthenticated) {
                                return const LoginView();
                              }
                              if (state.status ==
                                  AuthenticationStatus.authenticated) {
                                return MainScreen();
                              }
                              return SplashView();
                            },
                          );
                        },
                      );
                    },
                    localizationsDelegates: const [
                      S.delegate,
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: S.delegate.supportedLocales,
                    debugShowCheckedModeBanner: false,
                    theme: isDark ? AppTheme.lightTheme : AppTheme.darkTheme,
                    darkTheme: AppTheme.darkTheme,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
