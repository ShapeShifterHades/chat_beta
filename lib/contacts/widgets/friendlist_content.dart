import 'package:firestore_repository/src/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/authentication/authentication.dart';
import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/contact_tile.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';

class FriendlistContent extends StatefulWidget {
  @override
  _FriendlistContentState createState() => _FriendlistContentState();
}

class _FriendlistContentState extends State<FriendlistContent> {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        width: double.infinity,
        child: BlocBuilder<ContactsBloc, ContactsState>(
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
                    Divider(
                      color: Theme.of(context).primaryColor,
                      thickness: 0.2,
                    ),
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

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key key,
    @required this.sorted,
    @required this.index,
  }) : super(key: key);

  final List<Contact> sorted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ContactTile(
      id: 'ID: ${sorted[index].id.toUpperCase()}',
      child: Container(
        width: 300,
        height: 70,
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              // width: 70,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/avatar-placeholder.png',
                  colorBlendMode: BlendMode.color,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                '${sorted[index].username}',
                style: GoogleFonts.jura(fontSize: 16, color: Colors.white),
              ),
            ),
            Spacer(),
            Container(
              width: 60,
              padding: EdgeInsets.only(bottom: 20),
              child: IconButton(
                  icon: Icon(
                    Icons.fingerprint,
                    size: 34,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {}),
            ),
          ],
        ),
      ),
      // ),28
    );
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
//           onPressed: () => context.read<ContactsBloc>().add(
//                 SendFriendshipRequest(
//                   message: 'Add me mah boy',
//                   contactId: '54lsIRYehTQecNGEdc95EOvjVnv2',
//                   uid: context.read<AuthenticationBloc>().state.user.id,
//                 ),
//               ),
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
