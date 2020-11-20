import 'package:flutter/material.dart';

class SignScreenButton extends StatelessWidget {
  final String label;
  final List<Color> colors;
  final Color textColor;
  final Function func;

  const SignScreenButton(
      {Key key,
      @required this.label,
      @required this.colors,
      this.textColor,
      this.func})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: func,
      child: Container(
        alignment: Alignment.center,
        width: size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(color: textColor, fontSize: 16),
        ),
      ),
    );
  }
}
