import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/authentication/authentication.dart';
import 'package:void_chat_beta/blocs/contact_tabs/contact_tabs_bloc.dart';

import 'package:void_chat_beta/contacts/bloc/bloc/finduser_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/bloc/search_button_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/contact_page_tabs.dart';
import 'package:void_chat_beta/contacts/widgets/contact_page_tabs_content.dart';

import 'package:void_chat_beta/ui/ui.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactTabsBloc>(
            create: (context) => ContactTabsBloc(context.read<ContactBloc>())),
        BlocProvider<FinduserBloc>(
            create: (context) => FinduserBloc(
                context.read<AuthenticationBloc>(),
                context.read<FirestoreContactRepository?>())),
        BlocProvider<SearchButtonBloc>(
            create: (context) =>
                SearchButtonBloc(BlocProvider.of<FinduserBloc>(context))),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: UI(
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Column(
              children: [
                ContactPageTabs(),
                ContactPageTabsContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
