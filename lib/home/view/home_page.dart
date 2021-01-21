import 'package:flutter/material.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/ui/portrait_mobile_ui.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PortraitMobileUI(
        routeName: 'Messages',
        content: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Container(
              color: Colors.white24,
              child: Text(
                state.user.email + state.user.username,
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
