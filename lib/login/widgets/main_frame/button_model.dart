import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/ui/frontside/status_bar/screen_tag.dart';

class ButtonModel extends StatelessWidget {
  final bool enabled;
  final String text;
  final Function onPressed;
  const ButtonModel({
    Key key,
    @required this.text,
    this.onPressed,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      color: Theme.of(context).primaryColor,
      child: ClipPath(
        clipper: ScreenTagClipper(),
        child: MaterialButton(
          disabledColor: Theme.of(context).backgroundColor,
          onPressed: onPressed ?? () {},
          highlightColor: Theme.of(context).backgroundColor.withOpacity(0.14),
          child: Text(
            text,
            style: GoogleFonts.jura(
                fontWeight: FontWeight.w300,
                color: Theme.of(context).backgroundColor),
          ),
        ),
      ),
    );
  }
}
