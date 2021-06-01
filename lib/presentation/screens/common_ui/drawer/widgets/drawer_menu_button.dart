import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';

/// Represetation of an animated buttor for a drawer-side main menu.
class DrawerMenuButton extends StatefulWidget {
  /// State of a button, that represents current page it is and changes styling
  final CurrentView view;
  final AnimationController drawerController;

  ///  Text for button text
  final String? text;

  const DrawerMenuButton({
    Key? key,
    this.text,
    required this.drawerController,
    this.view = CurrentView.messages,
  }) : super(key: key);

  @override
  _DrawerMenuButtonState createState() => _DrawerMenuButtonState();
}

class _DrawerMenuButtonState extends State<DrawerMenuButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool isCurrentPage;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    isCurrentPage = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initAnimation() {
    _controller = AnimationController(duration: Times.medium, vsync: this);
    _animation = Tween<double>(begin: 18, end: 28)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainAppBloc, MainAppState>(
      builder: (context, state) {
        isCurrentPage =
            state is MainAppLoaded && state.currentView == widget.view;
        return GestureDetector(
          onTap: () {
            if (widget.view == CurrentView.contacts) {
              context.read<ContactTabsBloc>().add(FriendlistClicked());
            }
            BlocProvider.of<MainAppBloc>(context)
                .add(SwitchView(view: widget.view));
            widget.drawerController.reverse();
            _controller.forward();
          },
          child: Row(
            children: [
              CustomPaint(
                painter: DrawerMenuButtonPainter(
                    color: Theme.of(context).primaryColor,
                    current: isCurrentPage),
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
                            widget.text!,
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

/// Frame elements for [DrawerMenuButton].
class DrawerMenuButtonPainter extends CustomPainter {
  final bool pressed;
  final Color? color;
  final bool current;

  DrawerMenuButtonPainter(
      {this.color, this.pressed = false, this.current = false});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = current ? 1.5 : 0.3
      ..strokeCap = StrokeCap.round
      ..color = color!.withOpacity(0.8);

    final Path path1 = Path();
    path1.lineTo(size.width * 0.15, 0);
    path1.moveTo(size.width * 0.85, 0);
    path1.lineTo(size.width, 0);
    path1.lineTo(size.width, size.height * 0.15);
    path1.moveTo(size.width, size.height - 8);
    path1.lineTo(size.width - 8, size.height);
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

/// Clipper for [DrawerMenuButton].
class DrawerMenuButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width - 8, size.height);
    path.lineTo(size.width, size.height - 8);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
