import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/cubit/brightness/brightness.dart';

EdgeInsets buildFormMargin(BuildContext ctx) {
  return EdgeInsets.only(
    top: 40,
    left: MediaQuery.of(ctx).size.width * 0.03,
    right: MediaQuery.of(ctx).size.width * 0.03,
  );
}

BoxDecoration buildFormBackground1(BuildContext context) {
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

BoxDecoration buildFormBackground2(BuildContext context) {
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
              Color(0xffC7CCD1),
              Color(0xffBCC2C8),
            ],
    ),
  );
}

BoxDecoration buildFormBackground3(BuildContext context) {
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
              Color(0xffC7CCD1),
              Color(0xffBCC2C8),
            ],
    ),
  );
}

BoxDecoration buildFormBackground4(BuildContext context) {
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
              Color(0xffC7CCD1),
              Color(0xffBCC2C8),
            ],
    ),
  );
}

BoxDecoration buildFormBackground5(BuildContext context) {
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
              Color(0xffC7CCD1),
              Color(0xffBCC2C8),
            ],
    ),
  );
}
