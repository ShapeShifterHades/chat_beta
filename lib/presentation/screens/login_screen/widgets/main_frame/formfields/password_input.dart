import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/cubit/login/login_cubit.dart';

class PasswordInput extends StatefulWidget {
  final FocusNode node;

  const PasswordInput({Key? key, required this.node}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onEditingComplete: () =>
              context.read<LoginCubit>().logInWithCredentials(),
          textInputAction: TextInputAction.done,
          focusNode: widget.node,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: _obscureText,
          style: TextStyles.body2,
          decoration: InputDecoration(
            fillColor: Theme.of(context).backgroundColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.3,
                color: Theme.of(context).primaryColor,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.3,
                color: Theme.of(context).primaryColor,
              ),
            ),
            labelText: S.of(context).loginpage_password,
            helperText: '',
            errorText: state.password.invalid
                ? S.of(context).loginpage_invalid_password
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
    );
  }
}
