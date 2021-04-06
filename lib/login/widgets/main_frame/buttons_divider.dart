import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonsDivider extends StatelessWidget {
  const ButtonsDivider({
    Key key,
    @required this.orLineAlterHeight,
  }) : super(key: key);

  final Animation<double> orLineAlterHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
      ),
      width: Get.size.width * 0.9,
      height: orLineAlterHeight.value,
    );
  }
}
