import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/contacts_navigation.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/contacts_page_view.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/searchbar/user_search.dart';

class ContactsView extends StatefulWidget {
  const ContactsView({Key? key}) : super(key: key);

  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late PageController controller;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: BlocBuilder<ContactTabsBloc, ContactTabsState>(
        builder: (context, state) {
          final bool _isFriendList = state is! FriendlistState;
          final bool _isBlockList = state is! BlocklistState;
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 10),
            child: Column(
              children: [
                ContactsNavigation(
                  isFriendList: _isFriendList,
                  controller: controller,
                  isBlockList: _isBlockList,
                ),
                const UserSearch(),
                Expanded(
                  child: ContactsPageView(controller: controller),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
