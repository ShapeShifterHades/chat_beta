import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/signup/widgets/switcher.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:void_chat_beta/theme/locale_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsFrame extends StatelessWidget {
  const SettingsFrame({
    Key key,
    @required this.settingsFrameHeight,
  }) : super(key: key);

  final Animation<double> settingsFrameHeight;

  @override
  Widget build(BuildContext context) {
    _toggleLocale() {
      context.read<LocaleCubit>().toggleLocale();
      Get.updateLocale(Locale(context.read<LocaleCubit>().state));
    }

    return Container(
      decoration: buildFormBackground2(context),
      width: Get.size.width * 0.9,
      height: settingsFrameHeight.value,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 50),
                Text('signup_brightness'.tr, style: TextStyles.body1),
                const Spacer(),
                Switcher(
                  onChange: context.watch<BrightnessCubit>().toggleBrightness,
                ),
                const SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 50),
                Text('signup_locale'.tr, style: TextStyles.body1),
                const Spacer(),
                Switcher(
                  onChange: _toggleLocale,
                ),
                const SizedBox(width: 50),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
