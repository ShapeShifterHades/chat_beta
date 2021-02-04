import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SwitchAuthButton extends StatelessWidget {
  const SwitchAuthButton({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(width: 2),
        Shimmer.fromColors(
          baseColor: Theme.of(context)
              .inputDecorationTheme
              .enabledBorder
              .borderSide
              .color.withOpacity(0.35),
          highlightColor: Theme.of(context)
              .inputDecorationTheme
              .enabledBorder
              .borderSide
              .color.withOpacity(1),
          loop: 0,
          period: Duration(milliseconds: 2500),
          child: Row(
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 11,
                ),
              ),
              SizedBox(width: 10),
              Transform.translate(
                offset: Offset(0.0, 1.5),
                child: Transform(
                  transform: Matrix4.diagonal3Values(1, 0.85, 1.2),
                  child: Icon(
                    Icons.double_arrow,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
