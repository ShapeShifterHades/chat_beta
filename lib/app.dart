import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/constants.dart';
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

import 'home/home.dart';
import 'security/view/security_view.dart';
import 'theme/brightness_cubit.dart';
import 'theme/locale_cubit.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    this.authenticationRepository,
    this.firestoreNewUserRepository,
    this.firestoreContactRepository,
  }) : super(key: key);
  final AuthenticationRepository authenticationRepository;
  final FirestoreNewUserRepository firestoreNewUserRepository;
  final FirestoreContactRepository firestoreContactRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: firestoreNewUserRepository,
        ),
        RepositoryProvider.value(
          value: firestoreContactRepository,
        ),
        RepositoryProvider.value(
          value: authenticationRepository,
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<AuthenticationBloc>(
          lazy: false,
          create: (context) => AuthenticationBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          ),
        ),
        BlocProvider<LocaleCubit>(create: (context) => LocaleCubit()),
        BlocProvider<BrightnessCubit>(create: (context) => BrightnessCubit()),
        BlocProvider<ContactBloc>(
            lazy: false,
            create: (context) => ContactBloc(
                RepositoryProvider.of<FirestoreContactRepository>(context),
                context.read<AuthenticationBloc>())),
      ], child: AppView()),
    );
  }
}

class AppView extends StatelessWidget {
  AppView({Key key}) : super(key: key);

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
                          uid: context
                              .read<AuthenticationBloc>()
                              .state
                              .user
                              .id));
                      return ContactsView();
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
              theme: theme1(context, brightness),
            );
          },
        );
      },
    );
  }
}

// pages: [
//   Get.GetPage(
//       name: '/',
//       page: () {
//         return BlocBuilder<AuthenticationBloc,
//             AuthenticationState>(
//           builder: (context, state) {
//             if (state.status ==
//                 AuthenticationStatus.authenticated) {
//               context.watch<ContactBloc>();
//               return MessagesView();
//             } else {
//               return LoginView();
//             }
//           },
//         );
//       }),
//   Get.GetPage(
//       name: homeRoute,
//       page: () {
// BlocProvider.of<ContactBloc>(context).add(
//     LoadContacts(
//         uid: context
//             .read<AuthenticationBloc>()
//             .state
//             .user
//             .id));
//         return MessagesView();
//       }),
//   Get.GetPage(name: loginRoute, page: () => LoginView()),
//   Get.GetPage(
//       name: settingsRoute, page: () => SettingsView()),
//   Get.GetPage(
//       name: securityRoute, page: () => SecurityView()),
//   Get.GetPage(name: faqRoute, page: () => FaqView()),
//   Get.GetPage(
//     name: contactsRoute,
//     page: () => ContactsView(),
//   ),
//   Get.GetPage(
//     name: signupRoute,
//     page: () => SignUpView(),
//   ),
// ],
