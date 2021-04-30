import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';
import 'package:void_chat_beta/presentation/screens/signup_screen/widgets/simple_button_one.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SimpleButtonOne(
            text: S.of(context).signup_submit,
            onPressed: () {
              context.read<SignUpCubit>().signUpFormSubmitted();
            },
          ),
        ],
      ),
    );
  }
}
