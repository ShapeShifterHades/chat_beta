import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/messages/view/messages_view.dart';
import 'package:void_chat_beta/signup/view/signup_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:void_chat_beta/generated/l10n.dart';

import 'login/view/login_view.dart';
import 'settings/settings.dart';
import 'splash/view.dart/splash_view.dart';

import 'authentication/authentication.dart';
import 'contacts/bloc/contact_bloc.dart';

import 'contacts/view/contacts_view.dart';
import 'faq/view/faq_view.dart';

import 'security/view/security_view.dart';
import 'theme/brightness_cubit.dart';
import 'theme/locale_cubit.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthenticationRepository?>(
              create: (_) => AuthenticationRepository()),
          RepositoryProvider<FirestoreContactRepository?>(
              create: (_) => FirestoreContactRepository()),
          RepositoryProvider<FirestoreNewUserRepository?>(
              create: (_) => FirestoreNewUserRepository()),
          RepositoryProvider<FirestoreChatroomRepository?>(
              create: (_) => FirestoreChatroomRepository()),
        ],
        child: Builder(builder: (context) {
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(
                value:
                    RepositoryProvider.of<AuthenticationRepository?>(context),
              ),
              RepositoryProvider.value(
                value:
                    RepositoryProvider.of<FirestoreContactRepository?>(context),
              ),
              RepositoryProvider.value(
                value:
                    RepositoryProvider.of<FirestoreNewUserRepository?>(context),
              ),
              RepositoryProvider.value(
                value: RepositoryProvider.of<FirestoreChatroomRepository?>(
                    context),
              ),
            ],
            child: MultiBlocProvider(providers: [
              BlocProvider<AuthenticationBloc>(
                lazy: false,
                create: (context) => AuthenticationBloc(
                  authenticationRepository:
                      RepositoryProvider.of<AuthenticationRepository?>(context),
                ),
              ),
              BlocProvider<LocaleCubit>(
                create: (context) => LocaleCubit(),
                lazy: false,
              ),
              BlocProvider<BrightnessCubit>(
                create: (context) => BrightnessCubit(),
                lazy: false,
              ),
              BlocProvider<ContactBloc>(
                create: (context) => ContactBloc(
                    RepositoryProvider.of<FirestoreContactRepository?>(context),
                    context.read<AuthenticationBloc>()),
                lazy: false,
              ),
            ], child: AppView()),
          );
        }));
  }
}

class AppView extends StatelessWidget {
  AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrightnessCubit, Brightness>(
      builder: (context, brightness) {
        return BlocBuilder<LocaleCubit, String>(
          builder: (context, locale) {
            print('Aigght! : ${context.read<LocaleCubit>().state}');
            return MaterialApp(
              locale: Locale(context.read<LocaleCubit>().state),
              initialRoute: '/',
              routes: {
                '/': (context) {
                  return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                    if (state.status == AuthenticationStatus.unauthenticated)
                      return LoginView();
                    if (state.status == AuthenticationStatus.authenticated) {
                      BlocProvider.of<ContactBloc>(context).add(LoadContacts(
                          uid: BlocProvider.of<AuthenticationBloc>(context)
                              .state
                              .user
                              .id));
                      return MessagesView();
                    }

                    return SplashView();
                  });
                },
                loginRoute: (context) => LoginView(),
                signupRoute: (context) => SignUpView(),
                settingsRoute: (context) => SettingsView(),
                securityRoute: (context) => SecurityView(),
                homeRoute: (context) => MessagesView(),
                faqRoute: (context) => FaqView(),
                contactsRoute: (context) => ContactsView(),
              },
              onGenerateRoute: (_) => SplashView.route(),
              localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              theme: getTheme(context, brightness),
            );
          },
        );
      },
    );
  }
}
