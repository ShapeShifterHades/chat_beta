import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/authentication/authentication.dart';
import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';

class PendinglistContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        height: 500,
        width: double.infinity,
        child: BlocBuilder<ContactsBloc, ContactsState>(
          builder: (context, state) {
            if (state is ContactsAreLoading)
              return CircularProgressIndicator();
            else if (state is ContactsLoaded) {
              var sorted = state.contacts
                  .toList()
                  .where((element) => element.status.contains('pending'))
                  .toList();
              return Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Requests: ${sorted.length}',
                          style: GoogleFonts.jura(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 0.2,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: sorted.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Container(
                              color: Colors.brown,
                              width: 300,
                              child: Column(
                                children: [
                                  Text(sorted[index].username),
                                  Text(sorted[index].status),
                                  Text(sorted[index].id),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                  ],
                ),
              );
            } else
              return Container(
                child: Text(state.toString()),
              );
          },
        ),
      ),
    ]);
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
