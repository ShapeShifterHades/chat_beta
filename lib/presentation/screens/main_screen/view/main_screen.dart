import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/find_user/finduser_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:void_chat_beta/logic/bloc/search_button/search_button_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/view/chat_view.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/contacts.dart';
import 'package:void_chat_beta/presentation/screens/faq_screen/view/faq_view.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/view/messages_view.dart';
import 'package:void_chat_beta/presentation/screens/security_screen/view/security_view.dart';
import 'package:void_chat_beta/presentation/screens/settings_screen/view/settings_view.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainAppBloc()..add(LoadMainApp()),
      child: Builder(builder: (context) {
        /// Do setUp Job
        ///
        ///                                  BlocProvider.of<ContactBloc>(context);
        BlocProvider.of<ContactTabsBloc>(context);
        BlocProvider.of<ChatroomBloc>(context);
        BlocProvider.of<FinduserBloc>(context);
        BlocProvider.of<SearchButtonBloc>(context);

        ///
        BlocProvider.of<MainAppBloc>(context).add(const SwitchView());
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: UI(
            body: BlocBuilder<MainAppBloc, MainAppState>(
              builder: (context, state) {
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
                  }
                }
                return Text(
                  'Loading !!!',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
