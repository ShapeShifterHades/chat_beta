import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/login/login.dart';
import 'package:void_chat_beta/ui/main_side/frame/auth_custom_frame/portrait/custom_clip_path.dart';
import 'package:void_chat_beta/ui/main_side/frame/auth_custom_frame/portrait/custom_painter_for_clipper.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:formz/formz.dart';
import 'package:void_chat_beta/widgets/switch_auth_button.dart';

import '../sign_up.dart';

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
          child: Container(
            margin: EdgeInsets.only(top: 90),
            width: 280,
            child: SingleChildScrollView(
              child: CustomPaint(
                painter: CustomPainterForClipper(),
                child: ClipPath(
                  clipper: CustomClipPath(),
                  child: Column(
                    children: [
                      FormTopUi(() {}),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _EmailInput(),
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
          ),
        ),
      ),
    );
  }
}

class FormTopUi extends StatelessWidget {
  const FormTopUi(this.switcherOut);
  final Function switcherOut;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.watch<SignUpCubit>().state.status.isValidated
          ? () => context.read<SignUpCubit>().signUpFormSubmitted()
          : null,
      child: Container(
        height: 80,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: context
                          .watch<SignUpCubit>()
                          .state
                          .status
                          .isSubmissionInProgress
                      ? const CircularProgressIndicator()
                      : Text(
                          'REGISTER',
                          style: GoogleFonts.jura(
                            letterSpacing: 4,
                            fontWeight: FontWeight.w600,
                            fontSize: 26,
                            color: kMainBgColor,
                          ),
                        ),
                ),
                SizedBox(width: 12),
                Icon(Icons.input,
                    color: Theme.of(context).backgroundColor, size: 36),
                SizedBox(width: 3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).push<void>(LoginPage.route()),
                  onPanUpdate: (details) {
                    if (details.delta.dx > 0) {
                      Navigator.of(context).push<void>(LoginPage.route());
                    }
                  },
                  child: Container(
                    height: 38,
                    width: 220,
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(14),
                      ),
                    ),
                    child: SwitchAuthButton(
                      text: 'SWITCH TO LOGIN',
                    ),
                  ),
                ),
                SizedBox(width: 4),
              ],
            ),
            SizedBox(height: 2),
          ],
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
                context.read<SignUpCubit>().emailChanged(email),
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
            key: const Key('loginForm_confirmPasswordInput_textField'),
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
