import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/contacts/bloc/bloc/finduser_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_username_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'found_user_ui.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({
    Key key,
  }) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final finduserController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool isVisible = false;

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

  void find(context) async {
    // finduserController.value.text.length < 6
    //     ? print('invalid username')
    //     : print(finduserController.value.text);
    setState(() {
      isVisible = !isVisible;
    });
    return BlocProvider.of<FinduserBloc>(context)
        .add(FinduserEvent(finduserController.value.text));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SearchUsernameInput(
                  focusNode: _focusNode,
                  myController: finduserController,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  find(context);
                },
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.cyan,
                ),
              )
            ],
          ),
          isVisible
              ? Container(
                  child: BlocBuilder<FinduserBloc, FinduserState>(
                    cubit: BlocProvider.of<FinduserBloc>(context),
                    builder: (BuildContext context, FinduserState state) {
                      if (state.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.hasError) {
                        return Container(
                          child: Text('Error'),
                        );
                      }
                      return FoundUserUi(
                        result: state.contact,
                        finduserController: finduserController,
                        focusNode: _focusNode,
                        isVisible: isVisible,
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
