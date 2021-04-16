import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';
import 'package:void_chat_beta/constants/constants.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/ui/drawer/widgets/drawer_menu_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/widgets/arctext.dart';

class DrawerPM extends StatelessWidget {
  DrawerPM({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Row(
        children: [
          SizedBox(width: _width * 0.04),
          Column(
            children: [
              const SizedBox(height: 32),
              const _ProfileAvatarBlock(),
              const _MenuButtonsBlock()
            ],
          ),
        ],
      ),
    );
  }
}

class _MenuButtonsBlock extends StatelessWidget {
  const _MenuButtonsBlock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DrawerMenuButton(
              isCurrentPage: Get.arguments == 'Messages',
              label: 'drawer_messages'.tr,
              func: () {
                Get.toNamed(homeRoute, arguments: 'Messages');
              },
            ),
            const SizedBox(height: 15),
            DrawerMenuButton(
              isCurrentPage: Get.arguments == 'Contacts',
              label: 'drawer_contacts'.tr,
              func: () {
                Get.toNamed(contactsRoute, arguments: 'Contacts');
              },
            ),
            const SizedBox(height: 15),
            DrawerMenuButton(
              isCurrentPage: Get.arguments == 'Settings',
              label: 'drawer_settings'.tr,
              func: () {
                Get.toNamed(settingsRoute, arguments: 'Settings');
              },
            ),
            const SizedBox(height: 15),
            DrawerMenuButton(
              isCurrentPage: Get.arguments == 'Security',
              label: 'drawer_security'.tr,
              func: () {
                Get.toNamed(securityRoute, arguments: 'Security');
              },
            ),
            const SizedBox(height: 15),
            DrawerMenuButton(
              isCurrentPage: Get.arguments == 'FAQ',
              label: 'drawer_faq'.tr,
              func: () {
                Get.toNamed(faqRoute, arguments: 'FAQ');
              },
            ),
            const SizedBox(height: 45),
            DrawerMenuButton(
              label: 'drawer_logout'.tr,
              func: () async {
                await FirebaseAuth.instance.signOut();
              },
            ),
            const SizedBox(height: 55),
            Container(
              padding: EdgeInsets.only(left: 15),
              height: 40,
              width: 170,
              child: Text(
                'drawer_slogan'.tr,
                style: TextStyles.body2,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatarBlock extends StatelessWidget {
  const _ProfileAvatarBlock({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
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
                Align(
                  alignment: Alignment.center,
                  child: ArcText(
                    radius: 52,
                    text:
                        'Id:   ${context.watch<AuthenticationBloc>().state.user.id.toLowerCase()}',
                    textStyle: TextStyles.body2,
                    startAngle: -2.16,
                  ),
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
      ),
    );
  }
}

class TestMenuTile extends StatelessWidget {
  final String text;
  const TestMenuTile({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.4,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        width: 200,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).backgroundColor,
          ),
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          border: Border.all(
            color: Theme.of(context).backgroundColor,
            width: 6,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
