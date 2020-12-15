import 'package:flutter/material.dart';
import 'package:void_chat_beta/constants.dart';
import 'package:void_chat_beta/ui_elements/custom_clip_path.dart';

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

class _AuthFormState extends State<AuthForm> {
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
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Container(
      child: Card(
        elevation: 0,
        color: kMainBgColor,
        margin: EdgeInsets.fromLTRB(30, 70, 30, 30),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipPath(
                    clipper: CustomClipPath(),
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                      // decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            onEditingComplete: () => node.nextFocus(),
                            key: ValueKey('email'),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                            cursorColor: Color(0xFF8C8E8D),
                            maxLines: 1,
                            style: TextStyle(
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
                              onEditingComplete: () => node.nextFocus(),
                              key: ValueKey('username'),
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                              style: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.w100,
                                  fontSize: 22),
                              cursorColor: Color(0xFF8C8E8D),
                              maxLines: 1,
                              autocorrect: true,
                              textCapitalization: TextCapitalization.words,
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
                            obscuringCharacter: '*',
                            onEditingComplete: () => _trySubmit(),
                            key: ValueKey('password'),
                            decoration: InputDecoration(
                              labelText: 'Password',
                            ),
                            style: TextStyle(
                                letterSpacing: 2,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w100,
                                fontSize: 22),
                            cursorColor: Color(0xFF8C8E8D),
                            maxLines: 1,
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
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(
                        _isLogin ? 'Login' : 'Signup',
                        style: TextStyle(
                          color: Color(0xFF8C8E8D),
                        ),
                      ),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        _isLogin
                            ? 'Create new account'
                            : 'I already have an account',
                        style: TextStyle(color: kMainTextColor),
                      ),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
