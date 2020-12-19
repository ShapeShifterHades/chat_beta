import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/provider/auth_ui_provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:void_chat_beta/ui/ui_base_elements/animated_frame/portrait/custom_full_frame_animated.dart';

import 'package:void_chat_beta/ui/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;
  var visibleKbrd = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          "bio": {
            "nickname": username,
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
      setState(() {
        _isLoading = false;
      });
    }
  }

  @protected
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        visibleKbrd = visible;
        setState(() {});
        print(visible);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          MediaQuery.of(context).orientation == Orientation.portrait
              ? Positioned(
                  top: size.width * 0.05 + 30,
                  bottom: size.width * 0.05,
                  left: size.width * 0.05,
                  right: size.width * 0.05,
                  child: CustomFullFrameAnimated(
                    size: size,
                  ),
                )
              : Container(),
          AnimatedAlign(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeIn,
            alignment: visibleKbrd ? Alignment.topCenter : Alignment.center,
            child: ChangeNotifierProvider(
              create: (context) => AuthUiProvider(),
              child: AuthForm(_submitAuthForm, _isLoading),
            ),
          ),
        ],
      ),
    );
  }
}
