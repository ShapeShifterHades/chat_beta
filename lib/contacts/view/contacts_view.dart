import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
      resizeToAvoidBottomInset: false,
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
                            child: BlocProvider(
                              create: (context) => SearchUserFormBloc(),
                              child: Builder(builder: (context) {
                                return UserSearch();
                              }),
                            ),
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

class UserSearch extends StatelessWidget {
  const UserSearch({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<SearchUserFormBloc, String, String>(
      onSubmitting: (context, state) {
        // TODO: implement listener
      },
      child: SingleChildScrollView(
          child: TextFieldBlocBuilder(
        enableSuggestions: false,
        textAlign: TextAlign.start,
        cursorColor: Theme.of(context).primaryColor,
        cursorWidth: 0.5,
        padding: EdgeInsets.all(0),
        style: GoogleFonts.jura(
            fontWeight: FontWeight.w300,
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.none),
        textFieldBloc: context.watch<SearchUserFormBloc>().username,
        decoration: InputDecoration(
          border: InputBorder.none,
          alignLabelWithHint: true,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: () => context.read<SearchUserFormBloc>().submit(),
            child: Transform.translate(
              offset: Offset(0.0, 8.0),
              child: Icon(
                Icons.search,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          labelText: 'Search by username...',
          labelStyle: GoogleFonts.jura(
            fontWeight: FontWeight.w300,
            color: Theme.of(context).primaryColor,
          ),
        ),
      )),
    );
  }
}

class SearchUserFormBloc extends FormBloc<String, String> {
  final username = TextFieldBloc(
    validators: [_min5Char],
    asyncValidatorDebounceTime: Duration(milliseconds: 300),
  );

  SearchUserFormBloc() {
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
      print(username.value);
      emitSuccess();
    } catch (e) {
      print(e);
      emitFailure();
    }
  }
}
