import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/presentation/styled_widgets/dialog_button.dart';

class LicenceScreen extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Times.medium;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.05);

  @override
  String get barrierLabel => 'Terms and conditions';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _buildOverlayContent(context),
        ),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Material(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              width: .7,
              color: Theme.of(context).backgroundColor.withOpacity(.7),
            ),
          ),
          color: Theme.of(context).primaryColor,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'TERMS AND CONDITIONS',
                    style: TextStyles.body1
                        .copyWith(color: Theme.of(context).backgroundColor),
                  ),
                ),
                Divider(height: 4, color: Theme.of(context).backgroundColor),
                const _LicenseContent(),
                Divider(height: 4, color: Theme.of(context).backgroundColor),
                DialogButton(
                  callback: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Go back',
                    style: TextStyles.body1.copyWith(
                        color: Theme.of(context).backgroundColor, fontSize: 18),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}

class _LicenseContent extends StatelessWidget {
  const _LicenseContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RawScrollbar(
        isAlwaysShown: true,
        thumbColor: Theme.of(context).backgroundColor.withOpacity(.7),
        radius: const Radius.circular(20),
        thickness: 5,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              licenseSample,
              style: TextStyles.body2
                  .copyWith(color: Theme.of(context).backgroundColor),
            ),
          ),
        ),
      ),
    );
  }
}
