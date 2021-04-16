import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/blocs/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/pendinglist_content.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/user_search.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/styles.dart';

import 'friendlist_content.dart';

class ContactPageTabsContent extends StatelessWidget {
  const ContactPageTabsContent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 32, top: 0),
          child: Column(
            children: [
              UserSearch(),
              _UserList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserList extends StatelessWidget {
  const _UserList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactTabsBloc, ContactTabsState>(
        cubit: BlocProvider.of<ContactTabsBloc>(context),
        builder: (context, state) {
          if (state is ContactlistLoading) {
            return Center(
              child: Text(
                'contacts_loading'.tr,
                style: TextStyles.body1,
              ),
            );
          }
          if (state is FriendlistState) {
            return FriendlistContent();
          }
          if (state is PendinglistState) {
            return PendinglistContent();
          }
          return Container();
        });
  }
}
