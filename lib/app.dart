import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/login/login.dart';

import 'settings/settings.dart';
import 'signup/sign_up.dart';
import 'splash/view.dart/splash_view.dart';
import 'translations/translations.dart';

import 'authentication/authentication.dart';
import 'contacts/bloc/contact_bloc.dart';

import 'contacts/view/contacts_view.dart';
import 'faq/view/faq_view.dart';
import 'home/home.dart';
import 'security/view/security_view.dart';
import 'theme/brightness_cubit.dart';
import 'theme/locale_cubit.dart';
import 'theme/theme.dart';
import 'package:get/get.dart' as Get;

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository _authenticationRepository =
        AuthenticationRepository();
    FirestoreNewUserRepository _firestoreNewUserRepository =
        FirestoreNewUserRepository();
    return RepositoryProvider.value(
      value: _firestoreNewUserRepository,
      child: RepositoryProvider.value(
        value: _authenticationRepository,
        child: BlocProvider<AuthenticationBloc>(
            lazy: false,
            create: (context) => AuthenticationBloc(
                  authenticationRepository: _authenticationRepository,
                ),
            child: BlocProvider(
              create: (context) => LocaleCubit(),
              child: BlocProvider<ContactBloc>(
                create: (context) => ContactBloc(FirestoreContactRepository(),
                    context.read<AuthenticationBloc>())
                  ..add(LoadContacts(
                      uid: context.read<AuthenticationBloc>().state.user.id)),
                child: BlocProvider(
                  create: (context) => BrightnessCubit(),
                  child: AppView(),
                ),
              ),
            )),
      ),
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
            return Get.GetMaterialApp(
              locale: Locale(context.watch<LocaleCubit>().state ??
                  Get.Get.deviceLocale.countryCode),
              // initialRoute: '/',
              // routingCallback: (routing) {
              //   if (routing.current == '/messages') {
              //     print('MiddleWare here adding an ContactBlocEvent');
              //   }
              // },
              onGenerateRoute: (_) => SplashView.route(),
              getPages: [
                Get.GetPage(
                    name: '/',
                    page: () {
                      return BlocBuilder<AuthenticationBloc,
                          AuthenticationState>(
                        builder: (context, state) {
                          if (state.status ==
                              AuthenticationStatus.authenticated) {
                            context.watch<ContactBloc>();
                            return MessagesView();
                          } else {
                            return LoginPage();
                          }
                        },
                      );
                    }),
                Get.GetPage(name: homeRoute, page: () => MessagesView()),
                Get.GetPage(name: loginRoute, page: () => LoginPage()),
                Get.GetPage(name: settingsRoute, page: () => SettingsView()),
                Get.GetPage(name: securityRoute, page: () => SecurityView()),
                Get.GetPage(name: faqRoute, page: () => FaqView()),
                Get.GetPage(
                  name: contactsRoute,
                  page: () => BlocProvider<ContactlistBloc>(
                    create: (context) =>
                        ContactlistBloc(context.read<ContactBloc>()),
                    child: ContactsView(),
                  ),
                ),
                Get.GetPage(
                  name: '/newSignUp',
                  page: () => SignUpPage(),
                ),
              ],
              defaultTransition: Get.Transition.size,
              transitionDuration: Duration(milliseconds: 300),
              translations: ContentTranslations(),
              debugShowCheckedModeBanner: false,
              theme: theme1(context, brightness),
              builder: (context, child) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: SystemUiOverlayStyle(
                    // For Android.
                    // Use [light] for white status bar and [dark] for black status bar.
                    statusBarIconBrightness:
                        context.watch<BrightnessCubit>().state ==
                                Brightness.light
                            ? Brightness.dark
                            : Brightness.light,
                  ),
                  child: BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {
                      switch (state.status) {
                        case AuthenticationStatus.unauthenticated:
                          Get.Get.offAllNamed(loginRoute);
                          break;
                        case AuthenticationStatus.authenticated:
                          Get.Get.offAllNamed(homeRoute, arguments: 'Messages');
                          break;
                        case AuthenticationStatus.unknown:
                          // Get.Get.offAllNamed(loginRoute);
                          break;
                      }
                    },
                    child: child,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
