import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/ui/ui.dart';

// import 'package:get/get.dart';
// import 'package:void_chat_beta/theme/brightness_cubit.dart';
// import 'package:void_chat_beta/theme/locale_cubit.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // floatingActionButton: Row(
      //   children: [
      //     SizedBox(width: 50),
      //     FloatingActionButton(
      //       onPressed: () {
      //         context.read<LocaleCubit>().toggleLocale();
      //         print(context.read<LocaleCubit>().state ??
      //             Get.deviceLocale.countryCode);
      //         Get.updateLocale(Locale(context.read<LocaleCubit>().state));
      //         context.read<BrightnessCubit>().toggleBrightness();
      //       },
      //     ),
      //   ],
      // ),
      body: UI(
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Center(
              child: Container(
                child: Text("nigga"),
              ),
            );
          },
        ),
      ),
    );
  }
}
