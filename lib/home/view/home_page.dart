import 'package:flutter/material.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/ui/portrait_mobile_ui.dart';

import 'package:get/get.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:void_chat_beta/theme/locale_cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          SizedBox(width: 50),
          FloatingActionButton(
            onPressed: () {
              context.read<LocaleCubit>().toggleLocale();
              print(context.read<LocaleCubit>().state ??
                  Get.deviceLocale.countryCode);
              Get.updateLocale(Locale(context.read<LocaleCubit>().state));
              context.read<BrightnessCubit>().toggleBrightness();
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: PortraitMobileUI(
        routeName: 'Messages',
        content: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Text(
                state.user.email + state.user.username,
                style: TextStyle(
                    color: Theme.of(context).primaryTextTheme.bodyText2.color),
              ),
            );
          },
        ),
      ),
    );
  }
}
