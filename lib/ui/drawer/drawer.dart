import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:void_chat_beta/ui/drawer/widgets/drawer_menu_button.dart';

class DrawerPM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.05),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 20),
                  Center(
                      child: Text(
                    'Yorkee\n v.1.0.0 beta',
                    style: GoogleFonts.jura(
                      fontSize: 26,
                      color: Theme.of(context).primaryTextTheme.bodyText1.color,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
                ],
              )),
              DrawerMenuButton(
                isCurrentPage: Get.arguments == 'Messages',
                label: 'Messages',
                func: () {
                  Get.toNamed("/messages", arguments: 'Messages');
                },
              ),
              SizedBox(height: 15),
              DrawerMenuButton(
                isCurrentPage: Get.arguments == 'Contacts',
                label: 'Contacts',
                func: () {
                  Get.toNamed("/contacts", arguments: 'Contacts');
                },
              ),
              SizedBox(height: 15),
              DrawerMenuButton(
                isCurrentPage: Get.arguments == 'Settings',
                label: 'Settings',
                func: () {
                  Get.toNamed("/settings", arguments: 'Settings');
                },
              ),
              SizedBox(height: 15),
              DrawerMenuButton(
                isCurrentPage: Get.arguments == 'Security',
                label: 'Security',
                func: () {
                  Get.toNamed("/security", arguments: 'Security');
                },
              ),
              SizedBox(height: 15),
              DrawerMenuButton(
                isCurrentPage: Get.arguments == 'FAQ',
                label: 'FAQ',
                func: () {
                  Get.toNamed("/faq", arguments: 'FAQ');
                },
              ),
              SizedBox(height: 45),
              DrawerMenuButton(
                label: 'Logout',
                func: () async {
                  await FirebaseAuth.instance.signOut();
                },
              ),
              SizedBox(height: 125),
            ],
          ),
        ),
      ],
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
