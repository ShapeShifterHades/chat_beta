import 'package:flutter/material.dart';

class StyledLoadSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
            valueColor:
                AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
          )),
    );
  }
}
