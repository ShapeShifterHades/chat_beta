import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';
import 'package:void_chat_beta/ui/drawer/widgets/drawer_menu_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/widgets/arctext.dart';

class DrawerPM extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Row(
        children: [
          SizedBox(width: _width * 0.04),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 32),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 15),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
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
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ArcText(
                                radius: 52,
                                text:
                                    'Id:   ${context.watch<AuthenticationBloc>().state.user.id.toLowerCase()}',
                                textStyle: GoogleFonts.jura(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColor,
                                ),
                                startAngle: 0,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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
                        SizedBox(height: 55),
                        Container(
                          padding: EdgeInsets.only(left: 15),
                          height: 40,
                          width: 170,
                          child: Text(
                            'YorKee - leave the choice to yourself.',
                            style: GoogleFonts.jura(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText1
                                  .color,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
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
