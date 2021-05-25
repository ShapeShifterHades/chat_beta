import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';

class EmailInput extends StatelessWidget {
  final FocusNode node;
  final FocusNode nextNode;
  const EmailInput({
    Key? key,
    required this.node,
    required this.nextNode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            focusNode: node,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              node.unfocus();
              FocusScope.of(context).requestFocus(nextNode);
            },
            style: TextStyles.body1,
            cursorColor: Theme.of(context).primaryColor,
            key: const Key('signUpForm_emailInput_textField'),
            onChanged: (email) =>
                context.read<SignUpCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: S.of(context).signup_email,
              helperText: '',
              errorText: state.email.invalid
                  ? S.of(context).signup_invalid_email
                  : null,
            ),
          );
        },
      ),
    );
  }
}
