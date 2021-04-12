import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class SearchUsernameInput extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController myController;

  const SearchUsernameInput({Key key, this.focusNode, this.myController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      style: GoogleFonts.jura(fontSize: 24),
      cursorColor: Theme.of(context).primaryColor,
      controller: myController,
      decoration: InputDecoration(
        labelText: 'contacts_search_username'.tr,
        helperText: '',
      ),
    );
  }
}
