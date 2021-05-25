import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/frontside/minimenu/mini_menu_tile.dart';

class MessagesIcon extends StatelessWidget {
  const MessagesIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MessagesMiniMenuTile(
      key: const Key('chatrooms_minimenu_buton'),
      isCurrentPage: (context.watch<MainAppBloc>().state is MainAppLoaded &&
              (context.watch<MainAppBloc>().state as MainAppLoaded)
                      .currentView ==
                  CurrentView.messages) ||
          context.watch<MainAppBloc>().state is MainAppDialog,
    );
  }
}

class MessagesMiniMenuTile extends StatefulWidget {
  final bool isCurrentPage;
  final CurrentView view;

  const MessagesMiniMenuTile(
      {Key? key, this.isCurrentPage = false, this.view = CurrentView.messages})
      : super(key: key);

  @override
  _MessagesMiniMenuTileState createState() => _MessagesMiniMenuTileState();
}

class _MessagesMiniMenuTileState extends State<MessagesMiniMenuTile>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
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
    final bool _isDialog =
        BlocProvider.of<MainAppBloc>(context).state is MainAppDialog;
    if (!widget.isCurrentPage) _controller.reverse();
    return GestureDetector(
      onTap: () {
        BlocProvider.of<MainAppBloc>(context).add(const SwitchView());

        _controller.forward();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 0.04,
            ),
          ),
        ),
        child: CustomPaint(
          painter: MiniMenuTilePainter(
              pressed: null, color: Theme.of(context).primaryColor),
          child: ClipPath(
            clipper: MiniMenuTileClipper(),
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.08),
              width: 34,
              height: 38,
              child: Center(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: !_isDialog
                            ? Icon(
                                Icons.chat,
                                key: const Key('chat'),
                                color: widget.isCurrentPage
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.7),
                                size: _animation.value,
                              )
                            : Icon(
                                Icons.forum,
                                key: const Key('dialog'),
                                color: Theme.of(context).primaryColor,
                                size: 28,
                              ));
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
