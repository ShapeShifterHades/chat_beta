import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:sqflite_repository/sqflite_repository.dart';
import 'package:void_chat_beta/ui/ui.dart';

ContactModel contactModel1 = ContactModel(name: 'Simon', status: 'friend');

class ContactsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<ContactBloc>().add(SendContactRequest(
            contactId: 'JBFVeK2jaFBB7VPYmgZZ',
            message: 'Please add me for fuck sake!')),
      ),
      body: UI(
        content: Column(
          children: [
            Row(
              children: [
                Text(
                  'Internal database',
                )
              ],
            ),
            Expanded(
              child: Container(
                child: BlocBuilder<ContactBloc, ContactsState>(
                  builder: (context, state) {
                    final contact = (state as ContactsLoaded)
                        .contacts
                        .firstWhere((contact) => contact.id == id,
                            orElse: () => null);
                    return contact == null
                        ? Container()
                        : Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              width: 50,
                              height: 50,
                              color: Colors.purple[900],
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

// state.status == ContactListStatus.loading
//                         ? Container()
//                         : state.status == ContactListStatus.loadedWithError
//                             ? Container(
//                                 child: Text(
//                                   'Error',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               )
//                             : Container(
//                                 child: ListView.builder(
//                                   itemCount: state.contacts.length,
//                                   itemBuilder: (context, index) {
//                                     ContactModel _contact =
//                                         state.contacts[index];
//                                     return Text(
//                                         _contact.id.toString() +
//                                             ' ' +
//                                             _contact.name +
//                                             ' ' +
//                                             _contact.status,
//                                         style: TextStyle(color: Colors.white));
//                                   },
//                                 ),
//                               )
