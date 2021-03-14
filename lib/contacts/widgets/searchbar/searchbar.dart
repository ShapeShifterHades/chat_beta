import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_bloc.dart';

import 'interactive_search_ui.dart';

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
    return FormBlocListener<SearchUserFormBloc, String, String>(
      onSubmitting: (context, state) async {
        // TODO: implement listener';
        // try {
        //   var result =
        // } catch (e) {
        // }
        print('AVTOBOTI VPERDE!!!');
      },
      onFailure: (context, state) {
        stateSearch = !stateSearch;
        print(stateSearch.toString());
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 48),
                Flexible(
                  fit: FlexFit.loose,
                  child: TextFieldBlocBuilder(
                    focusNode: _focusNode,
                    enableSuggestions: false,
                    textAlign: TextAlign.center,
                    suffixButton:
                        _focusNode.hasFocus ? SuffixButton.clearText : null,
                    clearTextIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          context.read<SearchUserFormBloc>().clear();
                          Future.delayed(Duration(milliseconds: 100),
                              () => _focusNode.unfocus());
                        });
                      },
                      child: Transform.translate(
                        offset: Offset(12.0, 8.0),
                        child: Icon(Icons.clear_sharp,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    cursorColor: Theme.of(context).primaryColor,
                    cursorWidth: 0.5,
                    expands: false,
                    padding: EdgeInsets.all(0),
                    style: GoogleFonts.jura(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.none),
                    textFieldBloc: context.watch<SearchUserFormBloc>().username,
                    decoration: InputDecoration(
                      helperText: ' ',
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                      focusedBorder: InputBorder.none,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      enabledBorder: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () =>
                            context.read<SearchUserFormBloc>().submit(),
                        child: Transform.translate(
                          offset: Offset(12.0, 8.0),
                          child: GestureDetector(
                            onTap: context.watch<SearchUserFormBloc>().submit,
                            child: Icon(
                              Icons.search,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                      labelText: '   Search by username...',
                      labelStyle: GoogleFonts.jura(
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InteractiveSearchUi(focusNode: _focusNode),
          ],
        ),
      ),
    );
  }
}
