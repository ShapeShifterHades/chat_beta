import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:void_chat_beta/styles.dart';

import 'contact_item_initial.dart';

class FriendlistContent extends StatelessWidget {
  FriendlistContent({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactsState>(
      builder: (context, state) {
        if (state is ContactsAreLoading)
          return CircularProgressIndicator();
        else if (state is ContactsLoaded) {
          var sorted = state.contacts
              .toList()
              .where((element) => element.status.contains('friend'))
              .toList();
          return Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'contacts_friends'.tr + ': ' + sorted.length.toString(),
                      style: TextStyles.body1,
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  padding: const EdgeInsets.only(top: 0),
                  shrinkWrap: true,
                  itemCount: sorted.length,
                  itemBuilder: (context, index) {
                    return ContactItem(
                      sorted: sorted,
                      index: index,
                    );
                  },
                ),
              ],
            ),
          );
        }
        return Text(
          'Error happend..',
          style: TextStyles.body1,
        );
      },
    );
  }
}
