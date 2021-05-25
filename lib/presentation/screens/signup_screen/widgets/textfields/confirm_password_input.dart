import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';

class ConfirmPasswordInput extends StatelessWidget {
  final FocusNode node;
  final FocusNode nextNode;
  const ConfirmPasswordInput({
    Key? key,
    required this.node,
    required this.nextNode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
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
            key: const Key('signUpForm_confirmedPasswordInput_textField'),
            onChanged: (confirmPassword) => context
                .read<SignUpCubit>()
                .confirmedPasswordChanged(confirmPassword),
            obscureText: true,
            decoration: InputDecoration(
              labelText: S.of(context).signup_confirm_password,
              helperText: '',
              errorText: state.confirmedPassword.invalid
                  ? S.of(context).signup_invalid_confirm_password
                  : null,
            ),
          );
        },
      ),
    );
  }
}
