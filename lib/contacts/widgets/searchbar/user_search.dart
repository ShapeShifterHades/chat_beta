import 'package:flutter/material.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_username_input.dart';

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SearchUsernameInput(),
        ],
      ),
    );
  }
}
