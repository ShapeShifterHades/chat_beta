import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:void_chat_beta/blocs/contactlist/contactlist_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/contact_page_tabs.dart';

import 'package:void_chat_beta/contacts/widgets/friendlist_content.dart';
import 'package:void_chat_beta/contacts/widgets/pendinglist_content.dart';
import 'package:void_chat_beta/ui/ui.dart';

class ContactsView extends StatefulWidget {
  @override
  _ContactsViewState createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  bool inFindUserMode;

  @override
  void initState() {
    inFindUserMode = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UI(
        body: BlocBuilder<ContactlistBloc, ContactlistState>(
            builder: (context, state) {
          return Container(
            child: Column(
              children: [
                ContactPageTabs(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 32, top: 18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 500),
                            width: double.infinity,
                            height: inFindUserMode ? 160 : 80,
                            color: inFindUserMode ? Colors.yellow : Colors.pink,
                          ),
                          state is FriendlistState
                              ? FriendlistContent()
                              : Container(),
                          state is PendinglistState
                              ? PendinglistContent()
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class AsyncValidationSearchUser extends FormBloc<String, String> {
  final username = TextFieldBloc(
    validators: [],
    asyncValidatorDebounceTime: Duration(milliseconds: 300),
  );

  AsyncValidationSearchUser() {
    addFieldBlocs(fieldBlocs: [username]);
    username.addAsyncValidators(
      [_checkUsername],
    );
  }

  static String _min5Char(String username) {
    if (username.length < 5) return 'Username must have at least 5 characters';
    return null;
  }

  Future<String> _checkUsername(String username) async {
    await Future.delayed(Duration(microseconds: 300));
  }

  @override
  void onSubmitting() async {
    try {
      // Emmit here bloc ... found user
    } catch (e) {
      print(e);
    }
  }
}
