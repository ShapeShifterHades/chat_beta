import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SvgBackground extends StatelessWidget {
  SvgBackground({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = context.watch<BrightnessCubit>().state == Brightness.dark;
    return SvgPicture.asset(
      isDark ? 'assets/images/bg-dark.svg' : 'assets/images/bg-light.svg',
      fit: BoxFit.fill,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}
