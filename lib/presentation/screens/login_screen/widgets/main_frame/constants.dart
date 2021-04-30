import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/cubit/brightness/brightness.dart';

BoxDecoration buildBgBoxDecoration(BuildContext context) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: context.watch<BrightnessCubit>().state == Brightness.dark
          ? [
              Color(0xFF2D2E2E),
              Color(0xFF141515),
            ]
          : [
              Color(0xffF4F5F6),
              Color(0xffFFFFFF),
            ],
    ),
  );
}

EdgeInsets buildMainFrameMargin(context) {
  return EdgeInsets.only(
    top: 40,
    left: MediaQuery.of(context).size.width * 0.03,
    right: MediaQuery.of(context).size.width * 0.03,
  );
}

BoxDecoration buildSettingsBoxDecoration(BuildContext context) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: context.watch<BrightnessCubit>().state == Brightness.dark
          ? [
              Color(0xff2f353c),
              Color(0xff181f27),
            ]
          : [
              Color(0xffE0E0E0),
              Color(0xffEBEBEB),
            ],
    ),
  );
}

BoxDecoration buildOrLineBoxDecoration(BuildContext context) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: context.watch<BrightnessCubit>().state == Brightness.dark
          ? [
              Color(0xff2f353c),
              Color(0xff181f27),
            ]
          : [
              Color(0xffE0E0E0),
              Color(0xffEBEBEB),
            ],
    ),
  );
}

BoxDecoration buildFormFieldBackground(BuildContext context) {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomCenter,
      colors: context.watch<BrightnessCubit>().state == Brightness.dark
          ? [
              Color(0xff2f353c),
              Color(0xff181f27),
            ]
          : [
              Color(0xffE0E0E0),
              Color(0xffE0E0E0),
            ],
    ),
  );
}
