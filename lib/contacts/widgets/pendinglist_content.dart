import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/authentication/authentication.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';

class PendinglistContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Container(
        height: 500,
        width: double.infinity,
        child: BlocBuilder<ContactBloc, ContactsState>(
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
                              color: Colors.teal,
                              width: 300,
                              child: Column(
                                children: [
                                  Text(sorted[index].username),
                                  Text(sorted[index].status),
                                  Text(sorted[index].id),
                                  Text(sorted[index].message),
                                  Text(DateFormat.MMMMEEEEd()
                                      .format(sorted[index]
                                          .requestSentAt
                                          .toDate()
                                          .toLocal())
                                      .toString()),
                                  Divider(
                                    color: Colors.white,
                                  ),
                                ],
                              )),
                        );
                      },
                    ),
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 120,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,

                                  // height: 30,
                                  width: double.infinity,
                                  child: IconButton(
                                    icon: Icon(Icons.remove,
                                        color:
                                            Theme.of(context).backgroundColor),
                                    onPressed: () =>
                                        context.read<ContactBloc>().add(
                                              SendFriendshipRequest(
                                                message: 'Add me mah sweet boy',
                                                contactId: 'id',
                                                uid: context
                                                    .read<AuthenticationBloc>()
                                                    .state
                                                    .user
                                                    .id,
                                              ),
                                            ),
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 5,
                                            color: Theme.of(context)
                                                .backgroundColor)),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: CircleAvatar(
                                    backgroundImage: Image.asset(
                                            'assets/images/avatar-placeholder.png')
                                        .image),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 5,
                                            color: Theme.of(context)
                                                .backgroundColor)),
                                  ),
                                  width: double.infinity,
                                  // height: 30,
                                  child: IconButton(
                                    icon: Icon(Icons.add,
                                        color:
                                            Theme.of(context).backgroundColor),
                                    onPressed: () =>
                                        context.read<ContactBloc>().add(
                                              SendFriendshipRequest(
                                                message: 'Add me mah sweet boy',
                                                contactId: 'id',
                                                uid: context
                                                    .read<AuthenticationBloc>()
                                                    .state
                                                    .user
                                                    .id,
                                              ),
                                            ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(5),
                            height: 120,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      'Messsage',
                                      style: GoogleFonts.jura(
                                          color:
                                              Theme.of(context).backgroundColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Here will be all the shit that we wanna say sdfl'),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
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

class PendingUserPainter extends CustomPainter {
  final BuildContext context;

  PendingUserPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    double sw = size.width;
    double sh = size.height;
    double c = 10; // side size of rounded border.
    double r = 15; // tail size on the left side of widget.

    Paint framePaint = Paint()
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.stroke;

    Path framePath = Path()
      ..moveTo(r + c, 0)
      ..lineTo(sw - c, 0)
      ..quadraticBezierTo(sw, 0, sw, c)
      ..lineTo(sw, sh - c)
      ..quadraticBezierTo(sw, sh, sw - c, sh)
      ..lineTo(r + c, sh)
      ..quadraticBezierTo(r, sh, r, sh - c)
      ..lineTo(r, sh * 0.25)
      ..lineTo(r / 2, sh * 0.2)
      ..quadraticBezierTo(0, sh * 0.15, r / 2, sh * 0.15)
      ..lineTo(r, sh * 0.15)
      ..lineTo(r, c)
      ..quadraticBezierTo(r, 0, r + c, 0);

    canvas.drawPath(framePath, framePaint);
  }

  @override
  bool shouldRepaint(PendingUserPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PendingUserPainter oldDelegate) => false;
}

class PendingUserClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double sw = size.width;
    double sh = size.height;
    double c = 10; // side size of rounded border.
    double r = 15; // tail size on the left side of widget.
    Path path = Path()
      ..moveTo(r + c, 0)
      ..lineTo(sw - c, 0)
      ..quadraticBezierTo(sw, 0, sw, c)
      ..lineTo(sw, sh - c)
      ..quadraticBezierTo(sw, sh, sw - c, sh)
      ..lineTo(r + c, sh)
      ..quadraticBezierTo(r, sh, r, sh - c)
      ..lineTo(r, sh * 0.25)
      ..lineTo(r / 2, sh * 0.2)
      ..quadraticBezierTo(0, sh * 0.15, r / 2, sh * 0.15)
      ..lineTo(r, sh * 0.15)
      ..lineTo(r, c)
      ..quadraticBezierTo(r, 0, r + c, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
