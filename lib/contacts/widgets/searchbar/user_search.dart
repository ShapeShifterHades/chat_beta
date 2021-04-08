import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/contacts/search_cubit/searchuser_cubit.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_username_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({
    Key key,
  }) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  FocusNode _focusNode = FocusNode();
  var stateSearch = false;
  Contact contact;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    // The attachment will automatically be detached in dispose().
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    print("Focus: " + _focusNode.hasFocus.toString());
  }

  Future<Contact> find(context) async {
    return BlocProvider.of<SearchUsernameCubit>(context).findUsername();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchUsernameInput(
            focusNode: _focusNode,
          ),
          MaterialButton(
            onPressed: () async {
              contact = await find(context);
            },
            color: Colors.yellowAccent,
          ),
          Text(contact.id),
        ],
      ),
    );
  }
}
