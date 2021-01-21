import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/constants/constants.dart';

import 'package:void_chat_beta/ui/main_side/frame/auth_custom_frame/portrait/custom_clip_path.dart';
import 'package:void_chat_beta/ui/main_side/frame/auth_custom_frame/portrait/custom_painter_for_clipper.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:formz/formz.dart';

import '../sign_up.dart';
import 'form_header_signup.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
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
        () => _slideInController.forward().orCancel,
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
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Sign Up Failure')),
            );
        }
      },
      child: AnimatedAlign(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        alignment: visibleKbrd ? Alignment.topCenter : Alignment.center,
        child: SlideTransition(
          position: _slideInAnimation,
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(top: 90),
                width: 280,
                child: SingleChildScrollView(
                  child: CustomPaint(
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
                          FormHeaderSignUp(
                            color: state.status.isSubmissionFailure
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
                                        : 'REGISTRATION',
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _EmailInput(),
                                SizedBox(height: 20),
                                _UsernameInput(),
                                SizedBox(height: 20),
                                _PasswordInput(),
                                SizedBox(height: 20),
                                _ConfirmPasswordInput(),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.email != current.email,
        builder: (context, state) {
          return TextField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            key: const Key('signupForm_emailInput_textField'),
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
                context.read<SignUpCubit>().emailChanged(email),
          );
        });
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.username != current.username,
        builder: (context, state) {
          return TextField(
            textInputAction: TextInputAction.next,
            onEditingComplete: () => FocusScope.of(context).nextFocus(),
            key: const Key('signupForm_usernameInput_textField'),
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              labelText: 'Username',
              border: InputBorder.none,
              errorText: state.username.invalid ? 'invalid username' : null,
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
            keyboardType: TextInputType.name,
            onChanged: (username) =>
                context.read<SignUpCubit>().usernameChanged(username),
          );
        });
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) => previous.password != current.password,
        builder: (context, state) {
          return TextField(
            textInputAction: TextInputAction.next,
            obscuringCharacter: '•',
            key: const Key('signupForm_passwordInput_textField'),
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
                context.read<SignUpCubit>().passwordChanged(password),
          );
        });
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  const _ConfirmPasswordInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
        buildWhen: (previous, current) =>
            previous.password != current.password ||
            previous.confirmedPassword != current.confirmedPassword,
        builder: (context, state) {
          return TextFormField(
            textInputAction: TextInputAction.send,
            key: const Key('signupForm_confirmPasswordInput_textField'),
            obscuringCharacter: '•',
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              labelText: 'Confirm password',
              errorText: state.confirmedPassword.invalid
                  ? 'passwords do not match'
                  : null,
            ),
            style: GoogleFonts.jura(
                letterSpacing: 2,
                color: Colors.white,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w100,
                fontSize: 22),
            cursorColor: Color(0xFF8C8E8D),
            obscureText: true,
            enableSuggestions: false,
            onChanged: (confirmPassword) => context
                .read<SignUpCubit>()
                .confirmedPasswordChanged(confirmPassword),
            onEditingComplete:
                context.watch<SignUpCubit>().state.status.isValidated
                    ? () => context.read<SignUpCubit>().signUpFormSubmitted()
                    : null,
          );
        });
  }
}
