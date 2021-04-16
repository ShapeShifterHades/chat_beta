import 'package:flutter/material.dart';

import 'package:void_chat_beta/blocs/contact_tabs/contact_tabs_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:void_chat_beta/styles.dart';

class ContactPageTabs extends StatefulWidget {
  const ContactPageTabs({
    Key key,
  }) : super(key: key);

  @override
  _ContactPageTabsState createState() => _ContactPageTabsState();
}

class _ContactPageTabsState extends State<ContactPageTabs> {
  String dropdownValue;
  String tab1;
  String tab2;
  String tab3;
  @override
  void initState() {
    tab1 = 'contacts_friends'.tr;
    tab2 = 'contacts_pending'.tr;
    tab3 = 'contacts_blocked'.tr;
    dropdownValue = tab1;
    super.initState();
  }

  void sendEvent(String newValue) {
    if (newValue == tab1) {
      context.read<ContactTabsBloc>().add(FriendlistClicked());
    } else if (newValue == tab2) {
      context.read<ContactTabsBloc>().add(PendinglistClicked());
    } else if (newValue == tab3) {
      context.read<ContactTabsBloc>().add(BlocklistClicked());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 20, top: 10),
      width: 160,
      height: 35,
      child: Theme(
        data: Theme.of(context).copyWith(
            highlightColor: Theme.of(context).primaryColor.withOpacity(0.4)),
        child: DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_drop_down),
            iconEnabledColor: Theme.of(context).primaryColor,
            iconSize: 30,
            underline: SizedBox(),
            onChanged: (String newValue) {
              dropdownValue = newValue;
              sendEvent(newValue);
              setState(() {
                print(newValue);
              });
            },
            items: <String>[
              tab1,
              tab2,
              tab3,
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
