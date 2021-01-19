import 'package:authentication_repository/authentication_repository.dart';
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
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      body: PortraitMobileUI(
        routeName: 'Messages',
        content: Container(
          color: Colors.white24,
          child: Text(
            user.email + ' ' + user.username,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
