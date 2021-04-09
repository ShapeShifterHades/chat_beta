import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/contact_page_tabs.dart';
import 'package:void_chat_beta/contacts/widgets/contact_page_tabs_content.dart';

import 'package:void_chat_beta/ui/ui.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: UI(
        body: BlocBuilder<ContactlistBloc, ContactlistState>(
            builder: (context, state) {
          return GestureDetector(
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
          );
        }),
      ),
    );
  }
}
