import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthUiProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isLogin = false;

  bool get loginState => _isLogin;
  get formKey => _formKey;

  void trySubmit({
    BuildContext ctx,
    String userEmail = '',
    String userName = '',
    String userPassword = '',
  }) async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(ctx).unfocus();

    if (isValid) {
      _formKey.currentState.save();

      UserCredential userCredential;
      try {
        if (loginState) {
          userCredential = await _auth.signInWithEmailAndPassword(
              email: userEmail.trim(), password: userPassword.trim());
        } else {
          userCredential = await _auth.createUserWithEmailAndPassword(
              email: userEmail.trim(), password: userPassword.trim());
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user.uid)
              .set({
            "bio": {
              "nickname": userName.trim().toLowerCase(),
            },
          });
        }
      } catch (err) {
        var message = 'An error occured, please check your credentials';
        if (err.message != null) {
          message = err.message;
        }
        // errors are not forwarded to PlatformException
        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(ctx).errorColor,
          ),
        );
      }
    }
    notifyListeners();
  }

  void change() {
    _isLogin = !_isLogin;
    notifyListeners();
  }
}
