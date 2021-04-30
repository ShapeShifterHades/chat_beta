import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/cubit/brightness/brightness.dart';

class SvgBackground extends StatelessWidget {
  SvgBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<BrightnessCubit>().state == Brightness.dark;
    return SvgPicture.asset(
      isDark ? 'assets/images/bg-light.svg' : 'assets/images/bg-dark.svg',
      fit: BoxFit.fill,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}
