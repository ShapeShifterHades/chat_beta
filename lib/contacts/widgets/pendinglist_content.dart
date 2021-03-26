import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/tiles/outcoming_pending_request_tile.dart';

import 'tiles/incoming_pending_requests.dart';

class PendinglistContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
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
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: sorted.length,
                        itemBuilder: (context, index) {
                          var _date = sorted[index]?.requestSentAt == null
                              ? null
                              : DateFormat.MMMMEEEEd()
                                  .format(sorted[index]
                                      ?.requestSentAt
                                      ?.toDate()
                                      ?.toLocal())
                                  .toString();
                          return _date != null
                              ? (sorted[index].requestFrom ==
                                      context
                                          .watch<AuthenticationBloc>()
                                          .state
                                          .user
                                          .id)
                                  ? OutcomingPendingRequestTile(
                                      id: sorted[index].id,
                                      message: sorted[index].message,
                                      requestSentAt: _date,
                                      username: sorted[index].username,
                                    )
                                  : IncomingPendingRequestTile(
                                      id: sorted[index].id,
                                      message: sorted[index].message,
                                      requestSentAt: _date,
                                      username: sorted[index].username,
                                    )
                              : Container();
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
      ]),
    );
  }
}
