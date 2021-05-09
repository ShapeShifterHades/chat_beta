import 'package:flutter/material.dart';

EdgeInsets buildFormMargin(BuildContext ctx) {
  return EdgeInsets.only(
    top: 40,
    left: MediaQuery.of(ctx).size.width * 0.03,
    right: MediaQuery.of(ctx).size.width * 0.03,
  );
}
