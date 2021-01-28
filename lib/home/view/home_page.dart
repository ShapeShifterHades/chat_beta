import 'package:flutter/material.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/ui/drawer_side/portrait_mobile_drawer/widgets/drawer_menu_pm_tile.dart';
import 'package:void_chat_beta/ui/portrait_mobile_ui.dart';

import 'package:get/get.dart';
import 'package:void_chat_beta/theme/brightness_cubit.dart';
import 'package:void_chat_beta/theme/locale_cubit.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        children: [
          SizedBox(width: 50),
          FloatingActionButton(
            onPressed: () {
              context.read<LocaleCubit>().toggleLocale();
              print(context.read<LocaleCubit>().state ??
                  Get.deviceLocale.countryCode);
              Get.updateLocale(Locale(context.read<LocaleCubit>().state));
              context.read<BrightnessCubit>().toggleBrightness();
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).bottomAppBarColor,
      body: PortraitMobileUI(
        routeName: 'Messages',
        content: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                  left: -28,
                  bottom: 40 - Get.size.width * 0.01,
                  child: Container(
                    width: 50,
                    height: 419,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MiniMenuTile(
                          func: () {},
                          icon: Icons.message,
                        ),
                        SizedBox(height: 15),
                        MiniMenuTile(
                          func: () {},
                          icon: Icons.contacts,
                        ),
                        SizedBox(height: 15),
                        MiniMenuTile(
                          func: () {},
                          icon: Icons.settings,
                        ),
                        SizedBox(height: 15),
                        MiniMenuTile(
                          func: () {},
                          icon: Icons.lock,
                        ),
                        SizedBox(height: 15),
                        MiniMenuTile(
                          func: () {},
                          icon: Icons.help,
                        ),
                        SizedBox(height: 45),
                        MiniMenuTile(
                          func: () {},
                          icon: Icons.logout,
                        ),
                        SizedBox(height: 85),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  // color: Theme.of(context).backgroundColor,
                  child: Text(
                    state.user.email + state.user.username,
                    style: TextStyle(
                        color:
                            Theme.of(context).primaryTextTheme.bodyText2.color),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MiniMenuTile extends StatelessWidget {
  final IconData icon;
  final Function func;
  const MiniMenuTile({
    Key key,
    this.icon,
    this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: CustomPaint(
        painter: IconMenuPMTilePainter(
            pressed: func(),
            color: Theme.of(context).primaryTextTheme.bodyText1.color),
        child: ClipPath(
          clipper: IconMenuPMTileClipper(),
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.08),
            width: 34,
            height: 38,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Icon(
                  icon,
                  color: Theme.of(context).primaryTextTheme.bodyText1.color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class IconMenuPMTilePainter extends CustomPainter {
  final Color color;

  final bool pressed;

  IconMenuPMTilePainter({this.color, this.pressed = false});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = color.withOpacity(0.7);

    Path path1 = Path();
    path1.lineTo(size.width * 0.15, 0);
    path1.moveTo(size.width * 0.85, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height * 0.15);
    path1.moveTo(size.width, size.height * 0.85);
    path1.lineTo(size.width, size.height);
    path1.lineTo(size.width * 0.85, size.height);

    path1.moveTo(size.width * 0.15, size.height);
    path1.lineTo(0, size.height);
    path1.lineTo(0, size.height * 0.85);
    path1.moveTo(0, size.height * 0.15);
    path1.lineTo(0, 0);

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class IconMenuPMTileClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
