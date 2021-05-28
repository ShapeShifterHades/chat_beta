import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/brightness/brightness.dart';
import 'package:void_chat_beta/logic/cubit/locale/locale.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/switcher.dart';

class SettingsBox extends StatefulWidget {
  const SettingsBox({
    Key? key,
    required this.settingsFrameHeight,
  }) : super(key: key);

  final Animation<double>? settingsFrameHeight;

  @override
  _SettingsBoxState createState() => _SettingsBoxState();
}

class _SettingsBoxState extends State<SettingsBox> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: widget.settingsFrameHeight!.value,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor.withOpacity(.4),
            border: Border.symmetric(
              vertical:
                  BorderSide(color: Theme.of(context).primaryColor, width: .2),
            ),
          ),
          child: SingleChildScrollView(
            child: SizedBox(
              height: 168,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 50),
                      Text(S.of(context).signup_brightness,
                          style: TextStyles.body1
                              .copyWith(color: Theme.of(context).primaryColor)),
                      const Spacer(),
                      Switcher(
                        onChange:
                            context.watch<BrightnessCubit>().toggleBrightness,
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 50),
                      Text(S.of(context).signup_locale,
                          style: TextStyles.body1
                              .copyWith(color: Theme.of(context).primaryColor)),
                      const Spacer(),
                      Switcher(
                        onChange: () async {
                          BlocProvider.of<LocaleCubit>(context).toggleLocale();
                          setState(() {});
                        },
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
