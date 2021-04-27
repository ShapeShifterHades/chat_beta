import 'package:flutter/material.dart';
import 'package:void_chat_beta/contacts/bloc/bloc/finduser_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/bloc/search_button_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_username_input.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'found_user_ui.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({
    Key? key,
  }) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  final finduserController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    finduserController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    print("Focus: " + _focusNode.hasFocus.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchButtonBloc, SearchButtonState>(
        bloc: BlocProvider.of<SearchButtonBloc>(context),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
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
                      Transform.translate(
                        offset: Offset(0, -10),
                        child: Container(
                            alignment: Alignment.centerRight,
                            width: 50,
                            height: 50,
                            child: _buildIcon(context, state)),
                      ),
                    ],
                  ),
                  if (state.isExpanded!)
                    Container(
                      child: BlocBuilder<FinduserBloc, FinduserState>(
                        bloc: BlocProvider.of<FinduserBloc>(context),
                        builder: (BuildContext context, FinduserState state) {
                          if (state.isLoading!) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state.hasError!) {
                            return Container(
                              child: Text('Error'),
                            );
                          }
                          if (state.contact == null) {
                            return Text('User not found');
                          }

                          return FoundUserUi(
                            result: state.contact,
                            finduserController: finduserController,
                            focusNode: _focusNode,
                          );
                        },
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildIcon(BuildContext context, state) {
    if (state.status == SearchButtonStatus.initial) {
      return IconButton(
        icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
        onPressed: () async {
          BlocProvider.of<FinduserBloc>(context)
              .add(QueryEvent(finduserController.value.text));
          finduserController.clear();
          _focusNode.unfocus();
        },
      );
    } else if (state.status == SearchButtonStatus.loading) {
      return CircularProgressIndicator();
    } else if (state.status == SearchButtonStatus.hasError) {
      return Text('An error occured');
    }

    return IconButton(
      icon: Icon(Icons.close, color: Theme.of(context).primaryColor),
      onPressed: () {
        finduserController.clear();
        BlocProvider.of<SearchButtonBloc>(context)
            .add(SearchButtonResetEvent());
      },
    );
  }
}
