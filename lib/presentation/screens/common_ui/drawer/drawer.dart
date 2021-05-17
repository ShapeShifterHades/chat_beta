import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/drawer/widgets/arctext.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/drawer/widgets/drawer_menu_button.dart';

class DrawerBack extends StatelessWidget {
  const DrawerBack({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(width: _width * 0.04),
        Column(
          children: const [
            SizedBox(height: 32),
            _ProfileAvatarBlock(),
            _MenuButtonsBlock()
          ],
        ),
      ],
    );
  }
}

class _MenuButtonsBlock extends StatelessWidget {
  const _MenuButtonsBlock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DrawerMenuButton(
            label: S.of(context).drawer_messages,
            func: () {
              Navigator.of(context).pushNamed(homeRoute);
            },
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            label: S.of(context).drawer_contacts,
            func: () => Navigator.of(context).pushNamed(contactsRoute),
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            label: S.of(context).drawer_settings,
            func: () {
              Navigator.of(context).pushNamed(settingsRoute);
            },
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            label: S.of(context).drawer_security,
            func: () => Navigator.of(context).pushNamed(securityRoute),
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            label: S.of(context).drawer_faq,
            func: () => Navigator.of(context).pushNamed(faqRoute),
          ),
          const SizedBox(height: 45),
          DrawerMenuButton(
            label: S.of(context).drawer_logout,
            func: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
          ),
          const SizedBox(height: 55),
          Container(
            padding: const EdgeInsets.only(left: 15),
            height: 40,
            width: 170,
            child: Text(
              S.of(context).drawer_slogan,
              style: TextStyles.body2,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _ProfileAvatarBlock extends StatelessWidget {
  const _ProfileAvatarBlock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          const SizedBox(width: 15),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 136,
                height: 136,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(
                      width: 0.3,
                      color: Theme.of(context).primaryColor,
                    )),
                // child:,
              ),
              ArcText(
                radius: 52,
                text:
                    'Id:   ${context.watch<AuthenticationBloc>().state.user.id.toLowerCase()}',
                textStyle: TextStyles.body2
                    .copyWith(color: Theme.of(context).primaryColor),
                startAngle: -2.16,
              ),
              Container(
                width: 102,
                height: 102,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/avatar-placeholder.png',
                    color: Theme.of(context).bottomAppBarColor,
                    colorBlendMode: BlendMode.color,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
