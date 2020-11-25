import 'package:flutter/material.dart';
import 'package:void_chat_beta/helper/constants.dart';

class DontHaveAccountYet extends StatelessWidget {
  final String text1;
  final String text2;

  const DontHaveAccountYet(
      {Key key, @required this.text1, @required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(color: kMainTextColor),
        ),
        Text(
          text2,
          style: TextStyle(
            color: kMainTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}
