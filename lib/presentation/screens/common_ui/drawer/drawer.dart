import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';
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
            text: S.of(context).drawer_messages,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            text: S.of(context).drawer_contacts,
            view: CurrentView.contacts,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            text: S.of(context).drawer_settings,
            view: CurrentView.settings,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            text: S.of(context).drawer_security,
            view: CurrentView.security,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            text: S.of(context).drawer_faq,
            view: CurrentView.faq,
          ),
          const SizedBox(height: 45),
          const _ExitDrawerMenuButton(),
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

class _ExitDrawerMenuButton extends StatelessWidget {
  const _ExitDrawerMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerMenuButton(
      text: S.of(context).drawer_logout,
    );
  }
}

class _ProfileAvatarBlock extends StatefulWidget {
  const _ProfileAvatarBlock({
    Key? key,
  }) : super(key: key);

  @override
  __ProfileAvatarBlockState createState() => __ProfileAvatarBlockState();
}

class __ProfileAvatarBlockState extends State<_ProfileAvatarBlock> {
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
              GestureDetector(
                onTap: () {
                  getImage();
                  // print(_image!.path);
                  setState(() {});
                },
                child: Container(
                  width: 102,
                  height: 102,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Center(
                    child: _image == null
                        ? Text('No image selected.')
                        : Image.file(_image!),
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
