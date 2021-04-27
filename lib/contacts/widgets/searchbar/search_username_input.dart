import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/bloc/finduser_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/bloc/search_button_bloc.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/styles.dart';

class SearchUsernameInput extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? myController;

  const SearchUsernameInput({Key? key, this.focusNode, this.myController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: myController!.value.text.length < 1
          ? () {
              BlocProvider.of<SearchButtonBloc>(context)
                  .add(SearchButtonResetEvent());
            }
          : null,
      focusNode: focusNode,
      onEditingComplete: () {
        BlocProvider.of<FinduserBloc>(context)
            .add(QueryEvent(myController!.value.text));
      },
      style: TextStyles.body1,
      cursorColor: Theme.of(context).primaryColor,
      controller: myController,
      decoration: InputDecoration(
        labelText: S.of(context).contacts_search_username,
        helperText: '',
      ),
    );
  }
}
