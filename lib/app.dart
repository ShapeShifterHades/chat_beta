import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/newlogin/new_login.dart';

import 'new_signup/new_sign_up.dart';
import 'settings/settings.dart';
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
    this.firestoreContactRepository,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final FirestoreContactRepository firestoreContactRepository;

  setStatusColor(BuildContext context) async {
    await FlutterStatusbarcolor.setStatusBarColor(
        Theme.of(context).backgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    setStatusColor(context);
    return RepositoryProvider.value(
      value: (context) => firestoreContactRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: BlocProvider(
          create: (context) => ContactsBloc(
              firestoreContactRepository, context.read<AuthenticationBloc>())
            ..add(LoadContacts(
                uid: context.read<AuthenticationBloc>().state.user.id)),
          child: RepositoryProvider.value(
            value: authenticationRepository,
            child: BlocProvider(
              create: (context) => LocaleCubit(),
              child: BlocProvider(
                create: (context) => BrightnessCubit(),
                child: AppView(
                  authenticationRepository: authenticationRepository,
                ),
              ),
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

  /// Sets up [StatusBar] color to transparent
  setStatusColor(BuildContext context) async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
  }

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
                Get.GetPage(name: '/', page: () => NewLoginPage()),
                Get.GetPage(name: homeRoute, page: () => MessagesView()),
                Get.GetPage(name: loginRoute, page: () => NewLoginPage()),
                Get.GetPage(name: settingsRoute, page: () => SettingsView()),
                Get.GetPage(name: securityRoute, page: () => SecurityView()),
                Get.GetPage(name: faqRoute, page: () => FaqView()),
                Get.GetPage(name: contactsRoute, page: () => ContactsView()),
                Get.GetPage(
                  name: '/newSignUp',
                  page: () => RepositoryProvider.value(
                      value: firestoreNewUserRepository,
                      child: NewSignUpPage()),
                ),
              ],
              defaultTransition: Get.Transition.rightToLeftWithFade,
              transitionDuration: Duration(milliseconds: 300),
              translations: ContentTranslations(),
              debugShowCheckedModeBanner: false,
              theme: theme1(context, brightness),
              builder: (context, child) {
                // Here statusbar color is set to transparent
                setStatusColor(context);
                // Sets statusbar text color based on current [BrightnessCubit value].
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
                        default:
                          Get.Get.offAllNamed(loginRoute);
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
