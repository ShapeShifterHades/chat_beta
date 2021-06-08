import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/view/chat_view.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/view/contacts_view.dart';
import 'package:void_chat_beta/presentation/screens/faq_screen/view/faq_view.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/view/messages_view.dart';
import 'package:void_chat_beta/presentation/screens/security_screen/view/security_view.dart';
import 'package:void_chat_beta/presentation/screens/settings_screen/view/settings_view.dart';
import 'package:void_chat_beta/presentation/styled_widgets/styled_load_spinner.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  bool isFirstRun = true; // Wether app was already loaded.

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatroomBloc>(context).add(LoadChatrooms());
    BlocProvider.of<ContactBloc>(context).add(const LoadContacts());
  }

  late ContactsView contactsView;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => MainAppBloc(
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
        firebaseStorageRepository:
            RepositoryProvider.of<FirebaseStorageRepository>(context),
        firestoreHelperRepository:
            RepositoryProvider.of<FirestoreHelperRepository>(context),
      )..add(LoadMainApp()),
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: UI(
            body: BlocBuilder<MainAppBloc, MainAppState>(
              builder: (context, state) {
                final bool _chatroomLoaded =
                    context.watch<ChatroomBloc>().state is ChatroomLoaded;
                final bool _contactsLoaded =
                    context.watch<ContactBloc>().state is ContactsLoaded;
                if (state is MainAppLoading) {}

                if (state is MainAppDialog) {
                  return ChatView(chat: state.chat);
                }
                if (state is MainAppLoaded &&
                    _chatroomLoaded &&
                    _contactsLoaded) {
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
