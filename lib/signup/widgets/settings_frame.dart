import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/signup/widgets/switcher.dart';
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Brightness'),
                Switcher(
                  onChange: context.watch<BrightnessCubit>().toggleBrightness,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Locale'),
                Switcher(
                  onChange: _toggleLocale,
                ),
                SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
