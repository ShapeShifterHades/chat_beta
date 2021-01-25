import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/router/app_router.dart';
import 'package:void_chat_beta/settings/settings.dart';
import 'package:void_chat_beta/signup/sign_up.dart';
import 'package:void_chat_beta/translations/translations.dart';

import 'authentication/authentication.dart';
import 'contacts/bloc/contact_bloc.dart';
import 'package:sqflite_repository/sqflite_repository.dart';

import 'contacts/view/contacts_view.dart';
import 'faq/view/faq_view.dart';
import 'home/home.dart';
import 'login/login.dart';
import 'security/view/security_view.dart';
import 'theme/brightness_cubit.dart';
import 'theme/locale_cubit.dart';
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
            // child: BlocProvider(
            //   create: (context) => LocaleCubit(),
            child: BlocProvider(
                create: (context) => BrightnessCubit(), child: AppView()),
          ),
          // ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final FirestoreNewUserRepository firestoreNewUserRepository =
      FirestoreNewUserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrightnessCubit, Brightness>(
      builder: (context, brightness) {
        return GetMaterialApp(
          locale: Get.deviceLocale,
          initialRoute: '/',
          routingCallback: (routing) {
            if (routing.current == '/') {
              print('MiddleWare here. Ligh authcheck before page load.');
            }
          },
          getPages: [
            GetPage(name: '/', page: () => LoginPage()),
            GetPage(name: homeRoute, page: () => HomePage()),
            GetPage(name: loginRoute, page: () => LoginPage()),
            GetPage(name: settingsRoute, page: () => SettingsView()),
            GetPage(name: securityRoute, page: () => SecurityView()),
            GetPage(name: faqRoute, page: () => FaqView()),
            GetPage(name: contactsRoute, page: () => ContactsView()),
            GetPage(
              name: signupRoute,
              page: () => RepositoryProvider.value(
                  value: firestoreNewUserRepository, child: SignUpPage()),
            ),
          ],
          translations: LoginPageTranslations(),
          debugShowCheckedModeBanner: false,
          theme: theme1(context, brightness),
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    Get.offAllNamed(homeRoute);
                    break;
                  case AuthenticationStatus.unauthenticated:
                    Get.offAllNamed("/");
                    break;
                  default:
                    break;
                }
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
