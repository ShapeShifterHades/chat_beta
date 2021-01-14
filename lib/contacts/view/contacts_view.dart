import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/sqflite/bloc/contact_bloc.dart';
import 'package:void_chat_beta/sqflite/model/contact_model.dart';

import 'package:void_chat_beta/ui/portrait_mobile_ui.dart';

ContactModel contactModel1 = ContactModel(name: 'Simon', status: 'friend');

class ContactsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.read<ContactBloc>().add(ContactAdded(contactModel1)),
        // context.read<ContactBloc>().add(DeleteAllContacts()),
      ),
      body: PortraitMobileUI(
        routeName: 'Contacts',
        content: Column(
          children: [
            Row(
              children: [
                Text('Internal database', style: TextStyle(color: Colors.white))
              ],
            ),
            Expanded(
              child: Container(
                // color: Colors.amber.withOpacity(0.2),
                child: BlocBuilder<ContactBloc, ContactState>(
                  builder: (context, state) {
                    return state.status == ContactListStatus.loading
                        ? Container()
                        : state.status == ContactListStatus.loadedWithError
                            ? Container(
                                child: Text(
                                  'Error',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : Container(
                                child: ListView.builder(
                                  itemCount: state.contacts.length,
                                  itemBuilder: (context, index) {
                                    ContactModel _contact =
                                        state.contacts[index];
                                    return Text(
                                        _contact.id.toString() +
                                            ' ' +
                                            _contact.name +
                                            ' ' +
                                            _contact.status,
                                        style: TextStyle(color: Colors.white));
                                  },
                                ),
                              );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
