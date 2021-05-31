// ignore: implementation_imports
import 'package:firestore_repository/src/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/tiles/outcoming_pending_request_tile.dart';
import 'package:void_chat_beta/presentation/styled_widgets/loading_indicator.dart';

import '../tiles/incoming_pending_requests.dart';

class BlocklistContent extends StatelessWidget {
  const BlocklistContent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactBloc, ContactsState>(
      builder: (context, state) {
        if (state is ContactsLoaded) {
          final List<Contact> sorted = state.contacts
              .where((element) => element.status!.contains('blocked'))
              .toList();

          return Column(
            children: [
              _BlockedCounter(sorted: sorted),
              const _Divider(),
              if (sorted.isEmpty)
                const Expanded(
                  child: LoadingIndicator(
                    text: 'Blocklist is empty...',
                  ),
                )
              else
                _ContactsListView(sorted: sorted),
            ],
          );
        }
        return const CircularProgressIndicator();
      },
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
      height: 4,
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
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final String? _date = sorted[index].requestSentAt == null
            ? null
            : DateFormat.MMMMEEEEd().toString();
        return Column(
          children: [
            if (_date != null)
              (sorted[index].requestFrom ==
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
                    ),
          ],
        );
      },
    );
  }
}

class _BlockedCounter extends StatelessWidget {
  const _BlockedCounter({
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
          "${S.of(context).contacts_blocked} : ${sorted.length}",
          style: TextStyles.body1,
        ),
        const SizedBox(width: 20),
      ],
    );
  }
}
