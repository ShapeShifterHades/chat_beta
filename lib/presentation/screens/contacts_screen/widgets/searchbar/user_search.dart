import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/data/utils/safe_print.dart';
import 'package:void_chat_beta/logic/bloc/contacts_find_user/contacts_finduser_bloc.dart';
import 'package:void_chat_beta/logic/bloc/search_button/search_button_bloc.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/searchbar/search_username_input.dart';

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
    safePrint("Focus: ${_focusNode.hasFocus}");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchButtonBloc, SearchButtonState>(
        bloc: BlocProvider.of<SearchButtonBloc>(context),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: SearchUsernameInput(
                          focusNode: _focusNode,
                          myController: finduserController,
                        ),
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -10),
                      child: Container(
                          alignment: Alignment.centerRight,
                          width: 30,
                          height: 40,
                          child: _buildIcon(context, state)),
                    ),
                  ],
                ),
                if (state.isExpanded!)
                  BlocBuilder<ContactsFinduserBloc, ContactsFinduserState>(
                    bloc: BlocProvider.of<ContactsFinduserBloc>(context),
                    builder:
                        (BuildContext context, ContactsFinduserState state) {
                      if (state.isLoading!) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state.hasError!) {
                        return const Text('Error');
                      }
                      if (state.contact == null) {
                        return const Text('User not found');
                      }

                      return FoundUserUi(
                        result: state.contact,
                        finduserController: finduserController,
                        focusNode: _focusNode,
                      );
                    },
                  ),
              ],
            ),
          );
        });
  }

  Widget _buildIcon(BuildContext context, state) {
    if (state.status == SearchButtonStatus.initial) {
      return IconButton(
        icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
        onPressed: () async {
          BlocProvider.of<ContactsFinduserBloc>(context)
              .add(QueryEvent(finduserController.value.text));
          finduserController.clear();
          _focusNode.unfocus();
        },
      );
    } else if (state.status == SearchButtonStatus.loading) {
      return const CircularProgressIndicator();
    } else if (state.status == SearchButtonStatus.hasError) {
      return const Text('An error occured');
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
