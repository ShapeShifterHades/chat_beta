import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';

import 'contact_item_initial.dart';

enum AniProps { offset, containerOneHeight, containerTwoHeight }

class FriendlistContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: double.infinity,
        child: BlocBuilder<ContactBloc, ContactsState>(
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
                          'Friends: ${sorted.length}',
                          style: GoogleFonts.jura(
                              fontWeight: FontWeight.w300,
                              fontSize: 15,
                              color: Theme.of(context).primaryColor),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    SizedBox(height: 20),
                    ListView.builder(
                      padding: EdgeInsets.all(0),
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

// class ButtonsX extends StatelessWidget {
//   const ButtonsX({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         MaterialButton(
// onPressed: () => context.read<ContactsBloc>().add(
//       SendFriendshipRequest(
//         message: 'Add me mah boy',
//         contactId: '54lsIRYehTQecNGEdc95EOvjVnv2',
//         uid: context.read<AuthenticationBloc>().state.user.id,
//       ),
//     ),
//           child: Text('add'),
//           color: Colors.green,
//         ),
//         MaterialButton(
//           onPressed: () => context.read<ContactsBloc>().add(
//                 AcceptFriendshipRequest(
//                   contactId: '54lsIRYehTQecNGEdc95EOvjVnv2',
//                   uid: context.read<AuthenticationBloc>().state.user.id,
//                 ),
//               ),
//           child: Text('friend'),
//           color: Colors.yellowAccent,
//         ),
//       ],
//     );
//   }
// }
