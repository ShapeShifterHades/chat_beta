import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'settings/settings.dart';
import 'signup/sign_up.dart';
import 'translations/translations.dart';

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
import 'package:get/get.dart' as Get;

class App extends StatelessWidget {
  const App({
    Key key,
    this.firestoreContactRepository,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final FirestoreContactRepository firestoreContactRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: (context) => firestoreContactRepository,
      child: BlocProvider(
        create: (context) =>
            ContactBloc(firestoreContactRepository)..add(FriendListLoaded()),
        child: RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
            create: (_) => AuthenticationBloc(
              authenticationRepository: authenticationRepository,
            ),
            child: BlocProvider(
              create: (context) => LocaleCubit(),
              child: BlocProvider(
                  create: (context) => BrightnessCubit(),
                  child: AppView(
                    authenticationRepository: authenticationRepository,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  final FirestoreNewUserRepository firestoreNewUserRepository =
      FirestoreNewUserRepository();
  final AuthenticationRepository authenticationRepository;

  AppView({Key key, this.authenticationRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrightnessCubit, Brightness>(
      builder: (context, brightness) {
        return BlocBuilder<LocaleCubit, String>(
          builder: (context, locale) {
            return Get.GetMaterialApp(
              locale: Locale(context.watch<LocaleCubit>().state ??
                  Get.Get.deviceLocale.countryCode),
              initialRoute: homeRoute,
              routingCallback: (routing) {
                if (routing.current == '/') {
                  authenticationRepository.logOut();
                  print('MiddleWare here. Loggin Out.');
                }
              },
              getPages: [
                Get.GetPage(name: '/', page: () => LoginView()),
                Get.GetPage(name: homeRoute, page: () => MessagesView()),
                Get.GetPage(name: loginRoute, page: () => LoginView()),
                Get.GetPage(name: settingsRoute, page: () => SettingsView()),
                Get.GetPage(name: securityRoute, page: () => SecurityView()),
                Get.GetPage(name: faqRoute, page: () => FaqView()),
                Get.GetPage(name: contactsRoute, page: () => ContactsView()),
                Get.GetPage(
                  name: signupRoute,
                  page: () => RepositoryProvider.value(
                      value: firestoreNewUserRepository, child: SignUpView()),
                ),
              ],
              defaultTransition: Get.Transition.fadeIn,
              transitionDuration: Duration(milliseconds: 400),
              translations: ContentTranslations(),
              debugShowCheckedModeBanner: false,
              theme: theme1(context, brightness),
              builder: (context, child) {
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    switch (state.status) {
                      case AuthenticationStatus.authenticated:
                        Get.Get.offAllNamed(homeRoute, arguments: 'Messages');
                        break;
                      case AuthenticationStatus.unauthenticated:
                        Get.Get.offAllNamed(loginRoute);
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
      },
    );
  }
}
