import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/signup/signup_cubit.dart';

class ConfirmPasswordInput extends StatefulWidget {
  final FocusNode node;
  final FocusNode nextNode;
  const ConfirmPasswordInput({
    Key? key,
    required this.node,
    required this.nextNode,
  }) : super(key: key);

  @override
  _ConfirmPasswordInputState createState() => _ConfirmPasswordInputState();
}

class _ConfirmPasswordInputState extends State<ConfirmPasswordInput> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
            focusNode: widget.node,
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              widget.node.unfocus();
              FocusScope.of(context).requestFocus(widget.nextNode);
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
              suffixIcon: IconButton(
                icon: Icon(
                  // Based on passwordVisible state choose the icon
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColor,
                  size: 18,
                ),
                onPressed: _toggle,
              ),
            ),
          );
        },
      ),
    );
  }
}
