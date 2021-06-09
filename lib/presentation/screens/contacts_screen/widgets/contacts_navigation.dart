import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/contacts_tabs/contacts_tabs_bloc.dart';

class ContactsNavigation extends StatelessWidget {
  const ContactsNavigation({
    Key? key,
    required bool isFriendList,
    required this.controller,
    required bool isBlockList,
  })  : _isFriendList = isFriendList,
        _isBlockList = isBlockList,
        super(key: key);

  final bool _isFriendList;
  final PageController controller;
  final bool _isBlockList;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        AnimatedOpacity(
          opacity: _isFriendList ? 1 : 0,
          duration: Times.fast,
          child: IconButton(
            highlightColor: Colors.transparent,
            onPressed: () {
              controller.previousPage(
                  duration: Times.medium, curve: Curves.easeIn);
            },
            icon: FaIcon(
              FontAwesomeIcons.angleDoubleLeft,
              color: Theme.of(context).primaryColor.withOpacity(.7),
              size: 20,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextButton(
            onPressed: () {
              controller.nextPage(duration: Times.slow, curve: Curves.bounceIn);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                _getTabName(context),
                style: TextStyles.body1.copyWith(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity: _isBlockList ? 1 : 0,
          duration: Times.fast,
          child: IconButton(
            onPressed: () {
              controller.nextPage(
                duration: Times.medium,
                curve: Curves.easeIn,
              );
            },
            icon: FaIcon(
              FontAwesomeIcons.angleDoubleRight,
              color: Theme.of(context).primaryColor.withOpacity(.7),
              size: 20,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  String _getTabName(BuildContext context) {
    final ContactsTabsState _state = context.watch<ContactsTabsBloc>().state;
    if (_state is FriendlistState) {
      return S.of(context).contacts_friends;
    } else if (_state is PendinglistState) {
      return S.of(context).contacts_pending;
    }
    return S.of(context).contacts_blocked;
  }
}
