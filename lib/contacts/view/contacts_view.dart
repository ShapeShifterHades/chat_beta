import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';

import 'package:void_chat_beta/contacts/widgets/friendlist_content.dart';
import 'package:void_chat_beta/contacts/widgets/page_tabs.dart';
import 'package:void_chat_beta/contacts/widgets/pendinglist_content.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/searchbar.dart';
import 'package:void_chat_beta/ui/ui.dart';

class ContactsView extends StatefulWidget {
  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
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
            child: Container(
              child: Column(
                children: [
                  ContactPageTabs(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(left: 32, top: 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              width: double.infinity,
                              child: BlocProvider(
                                create: (context) => SearchUserFormBloc(),
                                child: Builder(builder: (context) {
                                  return UserSearch();
                                }),
                              ),
                            ),
                            state is FriendlistState
                                ? FriendlistContent()
                                : Container(),
                            state is PendinglistState
                                ? PendinglistContent()
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
