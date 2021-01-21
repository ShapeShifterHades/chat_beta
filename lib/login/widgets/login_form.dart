import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:void_chat_beta/constants/constants.dart';

import 'package:void_chat_beta/login/login.dart';
import 'package:void_chat_beta/ui/main_side/frame/auth_custom_frame/portrait/custom_clip_path.dart';
import 'package:void_chat_beta/ui/main_side/frame/auth_custom_frame/portrait/custom_painter_for_clipper.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:formz/formz.dart';

import '../login.dart';

import 'form_header.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> with TickerProviderStateMixin {
  bool visibleKbrd = false;
  AnimationController _slideInController;
  Animation<Offset> _slideInAnimation;

  @override
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        visibleKbrd = visible;
        setState(() {});
      },
    );

    _slideInController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideInAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideInController,
        curve: Curves.easeOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(milliseconds: 400),
        () => _slideInController.forward(),
      );
    });
  }

  @override
  void dispose() {
    _slideInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        }
      },
      child: AnimatedAlign(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        alignment: visibleKbrd ? Alignment.topCenter : Alignment.center,
        child: SlideTransition(
          position: _slideInAnimation,
          child: Container(
            margin: EdgeInsets.only(top: 90),
            width: 280,
            child: SingleChildScrollView(
              child: BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  return CustomPaint(
                    painter: CustomPainterForClipper(
                      color: state.status.isSubmissionFailure
                          ? Colors.red
                          : state.status.isValid
                              ? Colors.green
                              : state.status.isSubmissionInProgress
                                  ? Colors.yellow
                                  : kSecondaryColor,
                    ),
                    child: ClipPath(
                      clipper: CustomClipPath(),
                      child: Column(
                        children: [
                          FormHeader(
                            bgColor: state.status.isSubmissionFailure
                                ? Colors.red
                                : state.status.isValid
                                    ? Colors.green
                                    : state.status.isSubmissionInProgress
                                        ? Colors.yellow
                                        : kSecondaryColor,
                            title: state.status.isSubmissionFailure
                                ? 'FAILURE'
                                : state.status.isValid
                                    ? 'SUBMIT'
                                    : state.status.isSubmissionInProgress
                                        ? 'CONNECTING...'
                                        : 'LOGIN FORM',
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _EmailInput(),
                                SizedBox(height: 20),
                                _PasswordInput(),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            key: const Key('loginForm_emailInput_textField'),
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              labelText: 'Email',
              border: InputBorder.none,
              errorText: state.email.invalid ? 'invalid email' : null,
            ),
            cursorColor: Color(0xFF8C8E8D),
            maxLines: 1,
            style: GoogleFonts.jura(
                letterSpacing: 2,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w100,
                fontSize: 22),
            autocorrect: false,
            textCapitalization: TextCapitalization.none,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            textInputAction: TextInputAction.send,
            obscuringCharacter: '•',
            key: const Key('loginForm_passwordInput_textField'),
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              labelText: 'Password',
              errorText: state.password.invalid ? 'Invalid password' : null,
            ),
            style: GoogleFonts.jura(
                letterSpacing: 2,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w100,
                fontSize: 22),
            cursorColor: Color(0xFF8C8E8D),
            obscureText: true,
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            onEditingComplete:
                context.watch<LoginCubit>().state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
          );
        });
  }
}
