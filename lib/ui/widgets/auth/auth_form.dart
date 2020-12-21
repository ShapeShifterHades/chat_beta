import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/provider/auth_ui_provider.dart';
import 'package:void_chat_beta/ui/ui_base_elements/auth_custom_frame/portrait/custom_clip_path.dart';
import 'package:void_chat_beta/ui/ui_base_elements/auth_custom_frame/portrait/custom_painter_for_clipper.dart';
import 'package:void_chat_beta/ui/widgets/auth/switch_auth_button.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with TickerProviderStateMixin {
  bool visibleKbrd = false;
  AnimationController _slideInController;
  Animation<Offset> _slideInAnimation;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  bool switcher = false;

  void switcherOut() async {
    await _slideInController.reverse();
    context.read<AuthUiProvider>().change();
    await _slideInController.forward(from: -1.5);
  }

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

    // _slideInController.forward();
  }

  void trySubmit() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      UserCredential userCredential;
      try {
        if (!switcher) {
          userCredential = await _auth.signInWithEmailAndPassword(
              email: _userEmail.trim(), password: _userPassword.trim());
        } else {
          userCredential = await _auth.createUserWithEmailAndPassword(
              email: _userEmail.trim(), password: _userPassword.trim());
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user.uid)
              .set({
            "bio": {
              "nickname": _userName.trim().toLowerCase(),
            },
          });
        }
      } catch (err) {
        var message = 'An error occured, please check your credentials';
        if (err.message != null) {
          message = err.message;
        }
        // errors are not forwarded to PlatformException
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _slideInController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    switcher = Provider.of<AuthUiProvider>(context).loginState;
    return AnimatedAlign(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeIn,
      alignment: visibleKbrd ? Alignment.topCenter : Alignment.center,
      child: SlideTransition(
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
                              onTap: () => trySubmit(),
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
                                            // nigga.toString(),
                                            Provider.of<AuthUiProvider>(context)
                                                    .loginState
                                                ? 'REGISTER'
                                                : 'LOGIN',
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
                                                isLogin: !Provider.of<
                                                        AuthUiProvider>(context)
                                                    .loginState),
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
                                      labelText: 'Login',
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
                                      if (value.isEmpty ||
                                          !value.contains('@')) {
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
                                  if (Provider.of<AuthUiProvider>(context)
                                      .loginState)
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
                                  if (Provider.of<AuthUiProvider>(context)
                                      .loginState)
                                    SizedBox(height: 20),
                                  TextFormField(
                                    textInputAction: TextInputAction.send,
                                    obscuringCharacter: '•',
                                    onEditingComplete: () => trySubmit(),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
