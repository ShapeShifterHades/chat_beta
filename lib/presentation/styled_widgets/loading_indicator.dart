import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator(
      {Key? key, this.size = 16, this.text = "Fetching data, please wait..."})
      : super(key: key);
  final double size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Text(text,
            style: TextStyles.caption.copyWith(
                fontSize: size,
                color: Theme.of(context).primaryColor.withOpacity(.6)))
        //child: SizedBox(width: size, height: size, child: CircularProgressIndicator()),
        );
  }
}
