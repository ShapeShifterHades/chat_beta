import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/authentication/authentication.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:sqflite_repository/sqflite_repository.dart';
import 'package:void_chat_beta/ui/ui.dart';

ContactModel contactModel1 = ContactModel(name: 'Simon', status: 'friend');

class ContactsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UI(
        content: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            final isLoading = (state == ContactsAreLoading());
            final contact =
                isLoading ? null : (state as ContactsLoaded).contacts.toList();
            return isLoading
                ? CircularProgressIndicator()
                : contact == null
                    ? Container(
                        child: Text('No data'),
                      )
                    : Column(
                        children: [
                          ButtonsX(),
                          Container(
                            width: double.infinity,
                            height: 300,
                            child: ListView.builder(
                              itemCount: contact.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: GestureDetector(
                                    onTap: () {
                                      print('pressed on ${contact[index].id}');
                                      return context.read<ContactsBloc>().add(
                                            RemoveContactRequest(
                                              // message: 'Add me mah boy',
                                              contactId: context
                                                  .read<AuthenticationBloc>()
                                                  .state
                                                  .user
                                                  .id,
                                              uid: contact[index].id,
                                            ),
                                          );
                                    },
                                    child: Column(
                                      children: [
                                        Text('Friend $index'),
                                        Text(
                                            'name: ${contact[index].username}'),
                                        Text('id: ${contact[index].id}'),
                                        Text(
                                            'status: ${contact[index].status}'),
                                        Divider(),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
          },
        ),
      ),
    );
  }
}

class ButtonsX extends StatelessWidget {
  const ButtonsX({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(
          onPressed: () => context.read<ContactsBloc>().add(
                SendFriendshipRequest(
                  message: 'Add me mah boy',
                  contactId: '54lsIRYehTQecNGEdc95EOvjVnv2',
                  uid: context.read<AuthenticationBloc>().state.user.id,
                ),
              ),
          child: Text('add'),
          color: Colors.green,
        ),
        MaterialButton(
          onPressed: () => context.read<ContactsBloc>().add(
                AcceptFriendshipRequest(
                  contactId: '54lsIRYehTQecNGEdc95EOvjVnv2',
                  uid: context.read<AuthenticationBloc>().state.user.id,
                ),
              ),
          child: Text('friend'),
          color: Colors.yellowAccent,
        ),
      ],
    );
  }
}
