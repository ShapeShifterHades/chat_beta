import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/authentication/authentication.dart';

import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:void_chat_beta/contacts/search_cubit/searchuser_cubit.dart';

import 'package:void_chat_beta/contacts/widgets/friendlist_content.dart';
import 'package:void_chat_beta/contacts/widgets/page_tabs.dart';
import 'package:void_chat_beta/contacts/widgets/pendinglist_content.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/user_search.dart';
import 'package:void_chat_beta/ui/ui.dart';

class ContactsView extends StatelessWidget {
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
                                create: (context) => SearchUsernameCubit(
                                      context.read<AuthenticationBloc>(),
                                      context
                                          .read<FirestoreContactRepository>(),
                                    ),
                                child: UserSearch()),
                          ),
                          if (state is ContactlistLoading)
                            Center(
                              child: Text(
                                'Loading',
                                style: GoogleFonts.jura(
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                          if (state is FriendlistState) FriendlistContent(),
                          if (state is PendinglistState) PendinglistContent(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
