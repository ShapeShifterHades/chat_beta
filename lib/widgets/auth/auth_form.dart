import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/ui_elements/custom_clip_path.dart';
import 'package:void_chat_beta/ui_elements/custom_painter_for_clipper.dart';
import 'package:void_chat_beta/widgets/auth/switch_auth_button.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  AnimationController _slideInController;
  Animation<Offset> _slideInAnimation;

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim().toLowerCase(),
        _isLogin,
        context,
      );
    }
  }

  @override
  void initState() {
    super.initState();

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
        const Duration(milliseconds: 300),
        () => _slideInController.forward().orCancel,
      );
    });

    // _slideInController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _slideInController.dispose();
  }

  void switcherOut() async {
    await _slideInController.reverse();
    setState(() {
      _isLogin = !_isLogin;
    });
    await _slideInController.forward(from: -1.5);
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return SlideTransition(
      position: _slideInAnimation,
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 70, 30, 30),
        color: kMainBgColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomPaint(
                    painter: CustomPainterForClipper(),
                    child: ClipPath(
                      clipper: CustomClipPath(),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () => _trySubmit(),
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              color: kSecondaryColor,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          _isLogin ? 'LOGIN' : 'REGISTER',
                                          style: GoogleFonts.jura(
                                            letterSpacing: 4,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 32,
                                            color: kMainBgColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Icon(Icons.login,
                                          color: kMainBgColor, size: 36),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          switcherOut();
                                        },
                                        onPanUpdate: (details) {
                                          if (details.delta.dx > 0) {
                                            switcherOut();
                                          }
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 220,
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                            color: kMainBgColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(14),
                                            ),
                                          ),
                                          child: SwitchAuthButton(
                                              isLogin: _isLogin),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                    ],
                                  ),
                                  SizedBox(height: 2),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: kMainBgColor,
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 24),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  onEditingComplete: () => node.nextFocus(),
                                  key: ValueKey('email'),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: InputBorder.none,
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
                                  validator: (value) {
                                    if (value.isEmpty || !value.contains('@')) {
                                      return 'Please enter a valid email address.';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  onSaved: (value) {
                                    _userEmail = value;
                                  },
                                ),
                                SizedBox(height: 20),
                                if (!_isLogin)
                                  TextFormField(
                                    textInputAction: TextInputAction.next,
                                    onEditingComplete: () => node.nextFocus(),
                                    key: ValueKey('username'),
                                    decoration: InputDecoration(
                                      labelText: 'Username',
                                    ),
                                    style: GoogleFonts.jura(
                                        letterSpacing: 2,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w100,
                                        fontSize: 22),
                                    cursorColor: Color(0xFF8C8E8D),
                                    maxLines: 1,
                                    autocorrect: true,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    enableSuggestions: false,
                                    validator: (value) {
                                      if (value.isEmpty || value.length < 4) {
                                        return 'Please enter at least 4 characters';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _userName = value;
                                    },
                                  ),
                                if (!_isLogin) SizedBox(height: 20),
                                TextFormField(
                                  textInputAction: TextInputAction.send,
                                  obscuringCharacter: '•',
                                  onEditingComplete: () => _trySubmit(),
                                  key: ValueKey('password'),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                  ),
                                  style: GoogleFonts.jura(
                                      letterSpacing: 2,
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 22),
                                  cursorColor: Color(0xFF8C8E8D),
                                  validator: (value) {
                                    if (value.isEmpty || value.length < 7) {
                                      return 'Password must be at least 7 characters long.';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  onSaved: (value) {
                                    _userPassword = value;
                                  },
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // if (widget.isLoading) CircularProgressIndicator(),
                  // if (!widget.isLoading)
                  //   RaisedButton(
                  //     color: kMainBgColor,
                  //     child: Text(
                  //       _isLogin ? 'Login' : 'Signup',
                  //     ),
                  //     onPressed: _trySubmit,
                  //   ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
