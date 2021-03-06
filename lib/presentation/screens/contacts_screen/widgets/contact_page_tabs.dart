import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/data/utils/safe_print.dart';

import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/contacts_tabs/contacts_tabs_bloc.dart';

class ContactPageTabs extends StatefulWidget {
  const ContactPageTabs({
    Key? key,
  }) : super(key: key);

  @override
  _ContactPageTabsState createState() => _ContactPageTabsState();
}

class _ContactPageTabsState extends State<ContactPageTabs> {
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
  }

  void sendEvent(String? newValue) {
    if (newValue == S.of(context).contacts_friends) {
      context.read<ContactsTabsBloc>().add(ShowContactsFriendlist());
    } else if (newValue == S.of(context).contacts_pending) {
      context.read<ContactsTabsBloc>().add(ShowContactsPendinglist());
    } else if (newValue == S.of(context).contacts_blocked) {
      context.read<ContactsTabsBloc>().add(ShowContactsBlocklist());
    }
  }

  @override
  Widget build(BuildContext context) {
    dropdownValue = S.of(context).contacts_friends;
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 10),
      width: 160,
      height: 35,
      child: Theme(
        data: Theme.of(context).copyWith(
            highlightColor: Theme.of(context).primaryColor.withOpacity(0.4)),
        child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down),
            iconEnabledColor: Theme.of(context).primaryColor,
            iconSize: 30,
            onChanged: (String? newValue) {
              dropdownValue = newValue;
              sendEvent(newValue);
              setState(() {
                safePrint(newValue);
              });
            },
            items: <String>[
              S.of(context).contacts_friends,
              S.of(context).contacts_pending,
              S.of(context).contacts_blocked,
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    value,
                    style: TextStyles.body1.copyWith(fontSize: 18),
                  ),
                ),
              );
            }).toList()),
      ),
    );
  }
}
