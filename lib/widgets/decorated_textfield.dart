import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';

class DecoratedTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final validator;
  // final bool obsure;

  const DecoratedTextField({
    Key key,
    @required this.hintText,
    this.controller,
    this.validator,
    // this.obsure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // obscureText: obsure,
      validator: validator,
      controller: controller,
      style: TextStyle(color: kMainTextColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: kMainTextColor.withOpacity(0.6),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kMainTextColor,
          ),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: kMainTextColor,
          ),
        ),
      ),
    );
  }
}
