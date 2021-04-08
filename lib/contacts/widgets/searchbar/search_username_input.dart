import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/contacts/search_cubit/searchuser_cubit.dart';
import 'package:get/get.dart';

class SearchUsernameInput extends StatelessWidget {
  final FocusNode focusNode;

  const SearchUsernameInput({Key key, this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUsernameCubit, SearchUsernameState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          focusNode: focusNode,
          style: GoogleFonts.jura(fontSize: 24),
          cursorColor: Theme.of(context).primaryColor,
          key: const Key('search_username_textField'),
          onChanged: (username) =>
              context.read<SearchUsernameCubit>().usernameChanged(username),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'search_username'.tr,
            helperText: '',
            errorText:
                state.username.invalid ? 'signup_invalid_username'.tr : null,
          ),
        );
      },
    );
  }
}
