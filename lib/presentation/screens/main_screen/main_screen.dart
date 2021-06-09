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
import 'package:void_chat_beta/presentation/screens/security_screen/security_view.dart';
import 'package:void_chat_beta/presentation/screens/settings_screen/settings_view.dart';
import 'package:void_chat_beta/presentation/styled_widgets/styled_load_spinner.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late FirestoreContactRepository fsContactRepo;
  late FirestoreDialogsRepository fsChatRepo;
  late AuthenticationBloc authenticationBloc;
  late FirestoreMessageRepository fsMessageRepo;
  late FirebaseStorageRepository fbStorageRepo;
  late FirestoreHelperRepository fsHelperRepo;
  bool isFirstRun = true; // Wether app was already loaded.
  bool contactsLoaded = false;
  bool dialogsLoaded = false;
  bool contactsTabsLoaded = false;
  bool contactsFindUserLoaded = false;
  bool contactsSearchButtonLoaded = false;

  @override
  Widget build(BuildContext context) {
    fsContactRepo = RepositoryProvider.of<FirestoreContactRepository>(context);
    authenticationBloc = context.read<AuthenticationBloc>();
    fsChatRepo = RepositoryProvider.of<FirestoreDialogsRepository>(context);
    fsMessageRepo = RepositoryProvider.of<FirestoreMessageRepository>(context);
    fbStorageRepo = RepositoryProvider.of<FirebaseStorageRepository>(context);
    fsHelperRepo = RepositoryProvider.of<FirestoreHelperRepository>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactsBloc>(
            lazy: false,
            create: (context) => ContactsBloc(fsContactRepo, authenticationBloc)
              ..add(const LoadContacts())),
        BlocProvider<DialogsBloc>(
            lazy: false,
            create: (context) => DialogsBloc(
                  firestoreChatroomRepository: fsChatRepo,
                  authenticationBloc: authenticationBloc,
                )..add(LoadDialogs())),
        BlocProvider<ContactsTabsBloc>(
            create: (context) =>
                ContactsTabsBloc(contactsBloc: context.read<ContactsBloc>())),
        BlocProvider<ContactsFinduserBloc>(
            create: (context) => ContactsFinduserBloc(
                  authenticationBloc: authenticationBloc,
                  firestoreContactRepository: fsContactRepo,
                )),
        BlocProvider<SearchButtonBloc>(
            create: (context) => SearchButtonBloc(
                  finduserBloc: BlocProvider.of<ContactsFinduserBloc>(context),
                )),
        BlocProvider<MainAppBloc>(
            lazy: false,
            create: (context) => MainAppBloc(
                  authenticationBloc: authenticationBloc,
                  firebaseStorageRepository: fbStorageRepo,
                  firestoreHelperRepository: fsHelperRepo,
                )),
        BlocProvider<MessagesBloc>(
            create: (context) => MessagesBloc(
                  firestoreMessageRepository: fsMessageRepo,
                  authenticationBloc: authenticationBloc,
                )),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: UI(
            body: BlocListener<ContactsBloc, ContactsState>(
              listener: (context, state) {
                if (state is ContactsLoaded) {
                  context
                      .read<ContactsTabsBloc>()
                      .add(ShowContactsFriendlist());

                  contactsLoaded = true;
                  isFirstRun =
                      contactsLoaded && dialogsLoaded && contactsTabsLoaded;
                  if (isFirstRun) {
                    context.read<MainAppBloc>().add(LoadMainApp());
                  }
                }
              },
              child: BlocListener<DialogsBloc, DialogsState>(
                listener: (context, state) {
                  if (state is DialogsLoaded) {
                    dialogsLoaded = true;
                    isFirstRun =
                        contactsLoaded && dialogsLoaded && contactsTabsLoaded;
                    if (isFirstRun) {
                      context.read<MainAppBloc>().add(LoadMainApp());
                    }
                  }
                },
                child: BlocListener<ContactsTabsBloc, ContactsTabsState>(
                  listener: (context, state) {
                    if (state is FriendlistState) {
                      contactsTabsLoaded = true;
                      isFirstRun =
                          contactsLoaded && dialogsLoaded && contactsTabsLoaded;
                      if (isFirstRun) {
                        context.read<MainAppBloc>().add(LoadMainApp());
                      }
                    }
                  },
                  child: BlocBuilder<MainAppBloc, MainAppState>(
                    builder: (context, state) {
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
                            return const MessagesView();
                        }
                      }
                      return StyledLoadSpinner();
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
