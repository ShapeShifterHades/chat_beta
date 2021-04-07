import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/signup/widgets/switcher.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/theme/locale_cubit.dart';

class SettingsBox extends StatelessWidget {
  const SettingsBox({
    Key key,
    @required this.settingsFrameHeight,
  }) : super(key: key);

  final Animation<double> settingsFrameHeight;

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
      height: settingsFrameHeight.value,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Text('signup_brightness'.tr),
                Spacer(),
                Switcher(
                  onChange: context.watch<BrightnessCubit>().toggleBrightness,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 20),
                Text('signup_locale'.tr),
                Spacer(),
                Switcher(
                  onChange: () {
                    context.read<LocaleCubit>().toggleLocale();
                    Get.updateLocale(Locale(context.read<LocaleCubit>().state));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
