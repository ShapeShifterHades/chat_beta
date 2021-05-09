import 'package:flutter/material.dart';

EdgeInsets buildMainFrameMargin(BuildContext context) {
  return EdgeInsets.only(
    top: 40,
    left: MediaQuery.of(context).size.width * 0.03,
    right: MediaQuery.of(context).size.width * 0.03,
  );
}
