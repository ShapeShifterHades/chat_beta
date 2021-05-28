import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:void_chat_beta/core/themes/app_theme.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/find_user/finduser_bloc.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';
import 'package:void_chat_beta/logic/bloc/search_button/search_button_bloc.dart';
import 'package:void_chat_beta/logic/cubit/brightness/brightness.dart';
import 'package:void_chat_beta/logic/cubit/locale/locale.dart';

import 'package:void_chat_beta/presentation/screens/login_screen/view/login_view.dart';
import 'package:void_chat_beta/presentation/screens/main_screen/view/main_screen.dart';

import 'package:void_chat_beta/presentation/screens/splash_screen/splash.dart';

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
          RepositoryProvider<AuthenticationRepository>(
              create: (_) => AuthenticationRepository()),
          RepositoryProvider<FirestoreContactRepository?>(
              create: (_) => FirestoreContactRepository()),
          RepositoryProvider<FirestoreNewUserRepository>(
              create: (_) => FirestoreNewUserRepository()),
          RepositoryProvider<FirestoreChatroomRepository?>(
              create: (_) => FirestoreChatroomRepository()),
          RepositoryProvider<FirestoreMessageRepository?>(
              create: (_) => FirestoreMessageRepository()),
        ],
        child: Builder(builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider<AuthenticationBloc>(
              lazy: false,
              create: (context) => AuthenticationBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context),
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
                    context.read<AuthenticationBloc>())),
            BlocProvider<ChatroomBloc>(
              create: (context) => ChatroomBloc(
                firestoreChatroomRepository:
                    RepositoryProvider.of<FirestoreChatroomRepository?>(
                        context),
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
              )..add(LoadChatrooms()),
            ),
            BlocProvider<MessageBloc>(
              create: (context) => MessageBloc(
                firestoreMessageRepository:
                    RepositoryProvider.of<FirestoreMessageRepository?>(context),
                authenticationBloc:
                    BlocProvider.of<AuthenticationBloc>(context),
              ),
            ),
            BlocProvider<ContactTabsBloc>(
              create: (context) => ContactTabsBloc(
                context.read<ContactBloc>(),
              ),
            ),
            BlocProvider<FinduserBloc>(
              create: (context) => FinduserBloc(
                context.read<AuthenticationBloc>(),
                context.read<FirestoreContactRepository?>(),
              ),
            ),
            BlocProvider<SearchButtonBloc>(
              create: (context) => SearchButtonBloc(
                BlocProvider.of<FinduserBloc>(context),
              ),
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
                  return BlocListener<AuthenticationBloc, AuthenticationState>(
                    listener: (context, state) {},
                    child: MaterialApp(
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
                    ),
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
