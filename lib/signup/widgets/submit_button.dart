import 'package:flutter/material.dart';
import 'package:void_chat_beta/signup/cubit/signup_cubit.dart';
import 'package:void_chat_beta/signup/widgets/simple_button_one.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
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
            text: 'signup_submit'.tr,
            onPressed: () {
              context.read<SignUpCubit>().signUpFormSubmitted();
            },
          ),
        ],
      ),
    );
  }
}
