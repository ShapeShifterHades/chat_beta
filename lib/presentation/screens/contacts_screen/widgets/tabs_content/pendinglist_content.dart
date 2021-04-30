import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:firestore_repository/src/models/contact.dart';
import 'package:intl/intl.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/tiles/outcoming_pending_request_tile.dart';

import '../tiles/incoming_pending_requests.dart';

class PendinglistContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ContactBloc, ContactsState>(
        builder: (context, state) {
          if (state is ContactsLoaded) {
            var sorted = state.contacts
                .where((element) => element.status!.contains('pending'))
                .toList();

            return Container(
              child: Column(
                children: [
                  _RequestsCounter(sorted: sorted),
                  _Divider(),
                  _ContactsListView(sorted: sorted),
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).primaryColor,
      thickness: 0.2,
    );
  }
}

class _ContactsListView extends StatelessWidget {
  const _ContactsListView({
    Key? key,
    required this.sorted,
  }) : super(key: key);

  final List<Contact> sorted;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        var _date = sorted[index].requestSentAt == null
            ? null
            : DateFormat.MMMMEEEEd()
                // .format(sorted[index].requestSentAt?.toDate())
                .toString();
        return _date != null
            ? (sorted[index].requestFrom ==
                    context.watch<AuthenticationBloc>().state.user.id)
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
    );
  }
}

class _RequestsCounter extends StatelessWidget {
  const _RequestsCounter({
    Key? key,
    required this.sorted,
  }) : super(key: key);

  final List<Contact> sorted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          S.of(context).contacts_pending + ': ' + sorted.length.toString(),
          style: TextStyles.body1,
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
