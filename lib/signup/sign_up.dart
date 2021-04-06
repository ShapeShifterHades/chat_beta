import 'package:authentication_repository/authentication_repository.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';

import 'view/signup_view.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(
            AuthenticationRepository(),
            context.read<FirestoreNewUserRepository>(),
          ),
        ),
      ],
      child: SignUpView(),
    );
  }
}
