import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';

class ContactPageTabs extends StatelessWidget {
  const ContactPageTabs({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 50),
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: ScreenTag(
            child: GestureDetector(
              onTap: () {
                context.read<ContactlistBloc>().add(
                      FriendlistClicked(),
                    );
              },
              child: Container(
                width: 80,
                height: 32,
                color: context.watch<ContactlistBloc>().state is FriendlistState
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'Friends',
                    style: GoogleFonts.jura(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: context.watch<ContactlistBloc>().state
                              is FriendlistState
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Padding(
          padding: EdgeInsets.only(top: 0),
          child: ScreenTag(
            child: GestureDetector(
              onTap: () {
                context.read<ContactlistBloc>().add(PendinglistClicked());
              },
              child: Container(
                width: 80,
                height: 32,
                color:
                    context.watch<ContactlistBloc>().state is PendinglistState
                        ? Theme.of(context).backgroundColor
                        : Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'Pending',
                    style: GoogleFonts.jura(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: context.watch<ContactlistBloc>().state
                              is PendinglistState
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: ScreenTag(
            child: GestureDetector(
              onTap: () {
                context.read<ContactlistBloc>().add(BlocklistClicked());
              },
              child: Container(
                width: 80,
                height: 32,
                color: context.watch<ContactlistBloc>().state is BlocklistState
                    ? Theme.of(context).backgroundColor
                    : Theme.of(context).primaryColor,
                child: Center(
                  child: Text(
                    'Blocked',
                    style: GoogleFonts.jura(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: context.watch<ContactlistBloc>().state
                              is BlocklistState
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
