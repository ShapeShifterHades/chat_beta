import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/find_user/finduser_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:void_chat_beta/logic/bloc/search_button/search_button_bloc.dart';
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
  late final MessagesView messages;
  late final ContactsView contacts;
  @override
  void initState() {
    super.initState();
    messages = MessagesView();
    contacts = ContactsView();
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
                if (state is MainAppLoading) {
                  BlocProvider.of<ContactTabsBloc>(context);
                  BlocProvider.of<ChatroomBloc>(context).add(LoadChatrooms());
                  BlocProvider.of<FinduserBloc>(context);
                  BlocProvider.of<SearchButtonBloc>(context);
                }
                if (state is MainAppDialog) {
                  return ChatView(chat: state.chat);
                }
                if (state is MainAppLoaded) {
                  BlocProvider.of<ContactBloc>(context)
                      .add(const LoadContacts());

                  switch (state.currentView) {
                    case CurrentView.messages:
                      return messages;
                    case CurrentView.contacts:
                      return contacts;
                    case CurrentView.settings:
                      return SettingsView();
                    case CurrentView.security:
                      return SecurityView();
                    case CurrentView.faq:
                      return FaqView();
                    default:
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
