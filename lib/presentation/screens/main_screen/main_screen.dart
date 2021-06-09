import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contacts_find_user/contacts_finduser_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contacts_tabs/contacts_tabs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/dialogs/dialogs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contacts/contacts_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/main_bloc.dart';
import 'package:void_chat_beta/logic/bloc/messages/messages_bloc.dart';
import 'package:void_chat_beta/logic/bloc/search_button/search_button_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/chat_view.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/contacts_view.dart';
import 'package:void_chat_beta/presentation/screens/faq_screen/faq_view.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/messages_view.dart';
import 'package:void_chat_beta/presentation/screens/security_screen/view/security_view.dart';
import 'package:void_chat_beta/presentation/screens/settings_screen/view/settings_view.dart';
import 'package:void_chat_beta/presentation/styled_widgets/styled_load_spinner.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isFirstRun = true; // Wether app was already loaded.
  late FirestoreContactRepository? fsContactRepo;
  late FirestoreChatroomRepository? fsChatRepo;
  late AuthenticationBloc authenticationBloc;
  late FirestoreMessageRepository? fsMessageRepo;

  @override
  Widget build(BuildContext context) {
    fsContactRepo = RepositoryProvider.of<FirestoreContactRepository?>(context);
    authenticationBloc = context.read<AuthenticationBloc>();
    fsChatRepo = RepositoryProvider.of<FirestoreChatroomRepository?>(context);
    fsMessageRepo = RepositoryProvider.of<FirestoreMessageRepository?>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactsBloc>(
            create: (context) => ContactsBloc(fsContactRepo, authenticationBloc)
              ..add(const LoadContacts())),
        BlocProvider<DialogsBloc>(
            create: (context) => DialogsBloc(
                  firestoreChatroomRepository: fsChatRepo,
                  authenticationBloc: authenticationBloc,
                )..add(LoadDialogs())),
        BlocProvider<MessagesBloc>(
            create: (context) => MessagesBloc(
                  firestoreMessageRepository: fsMessageRepo,
                  authenticationBloc: authenticationBloc,
                )),
        BlocProvider<ContactsTabsBloc>(
            create: (context) => ContactsTabsBloc(
                  context.read<ContactsBloc>(),
                )),
        BlocProvider<ContactsFinduserBloc>(
            create: (context) => ContactsFinduserBloc(
                  authenticationBloc,
                  fsContactRepo,
                )),
        BlocProvider<SearchButtonBloc>(
            create: (context) => SearchButtonBloc(
                  finduserBloc: BlocProvider.of<ContactsFinduserBloc>(context),
                )),
        BlocProvider<MainAppBloc>(
          lazy: false,
          create: (context) => MainAppBloc(
            authenticationBloc: authenticationBloc,
            firebaseStorageRepository:
                RepositoryProvider.of<FirebaseStorageRepository>(context),
            firestoreHelperRepository:
                RepositoryProvider.of<FirestoreHelperRepository>(context),
          )..add(LoadMainApp()),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: UI(
            body: BlocBuilder<MainAppBloc, MainAppState>(
              builder: (context, state) {
                if (state is MainAppLoading) {}

                if (state is MainAppDialog) {
                  return ChatView(chat: state.chat);
                }
                if (state is MainAppLoaded) {
                  switch (state.currentView) {
                    case CurrentView.messages:
                      return const MessagesView();
                    case CurrentView.contacts:
                      return const ContactsView();
                    case CurrentView.settings:
                      return SettingsView();
                    case CurrentView.security:
                      return SecurityView();
                    case CurrentView.faq:
                      return FaqView();
                    default:
                      return MessagesView();
                  }
                }
                return StyledLoadSpinner();
              },
            ),
          ),
        );
      }),
    );
  }
}
