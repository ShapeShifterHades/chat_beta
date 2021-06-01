import 'dart:io';

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
  final AnimationController animationController;
  const DrawerBack({
    Key? key,
    required this.animationController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        SizedBox(width: _width * 0.04),
        Column(
          children: [
            const SizedBox(height: 32),
            const _ProfileAvatarBlock(),
            _MenuButtonsBlock(animationController: animationController)
          ],
        ),
      ],
    );
  }
}

class _MenuButtonsBlock extends StatelessWidget {
  final AnimationController animationController;

  const _MenuButtonsBlock({
    required this.animationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          DrawerMenuButton(
            drawerController: animationController,
            text: S.of(context).drawer_messages,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            drawerController: animationController,
            text: S.of(context).drawer_contacts,
            view: CurrentView.contacts,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            drawerController: animationController,
            text: S.of(context).drawer_settings,
            view: CurrentView.settings,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            drawerController: animationController,
            text: S.of(context).drawer_security,
            view: CurrentView.security,
          ),
          const SizedBox(height: 15),
          DrawerMenuButton(
            drawerController: animationController,
            text: S.of(context).drawer_faq,
            view: CurrentView.faq,
          ),
          const SizedBox(height: 45),
          ExitDrawerMenuButton(
              text: S.of(context).drawer_logout,
              drawerController: animationController),
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

class ExitDrawerMenuButton extends StatefulWidget {
  /// State of a button, that represents current page it is and changes styling
  final CurrentView view;
  final AnimationController drawerController;

  ///  Text for button text
  final String text;

  const ExitDrawerMenuButton({
    Key? key,
    required this.text,
    required this.drawerController,
    this.view = CurrentView.messages,
  }) : super(key: key);

  @override
  _ExitDrawerMenuButtonState createState() => _ExitDrawerMenuButtonState();
}

class _ExitDrawerMenuButtonState extends State<ExitDrawerMenuButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppBloc, MainAppState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationLogoutRequested());
            widget.drawerController.reverse();
          },
          child: Row(
            children: [
              CustomPaint(
                painter: DrawerMenuButtonPainter(
                    color: Theme.of(context).primaryColor),
                child: ClipPath(
                  clipper: DrawerMenuButtonClipper(),
                  child: Container(
                    width: 140,
                    height: 38,
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          const SizedBox(width: 30),
                          Text(
                            widget.text,
                            style: TextStyles.body1,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

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
                        ? CircleAvatar(
                            backgroundImage: Image.asset(
                                    'assets/images/avatar-placeholder.png')
                                .image,
                            radius: 60,
                            backgroundColor: Colors.transparent,
                          )
                        : CircleAvatar(
                            backgroundImage: Image.file(_image!).image,
                            radius: 60,
                            backgroundColor: Colors.transparent,
                          ),
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
