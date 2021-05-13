import 'dart:ui' as ui;

import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/message_bubble.dart';

enum MessageOwner { myself, other }

@immutable
class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.child,
    required this.animationController,
  }) : super(key: key);

  final MessageToSend message;
  final AnimationController animationController;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String authId =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    final bool isMine = message.senderId == authId;
    final messageAlignment = isMine ? Alignment.topRight : Alignment.topLeft;
    final String time = (message.timeSent != null)
        ? timeago.format(message.timeSent!).trim()
        : '';

    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.90,
      child: Align(
        alignment: messageAlignment,
        child: SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOut,
          ),
          axisAlignment: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: Column(
              crossAxisAlignment:
                  isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      time,
                      style: TextStyles.body2.copyWith(
                          fontSize: 8,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.64)),
                    ),
                    if (isMine) MessageStatusDot(message),
                  ],
                ),
                const SizedBox(height: 3),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).backgroundColor,
                        spreadRadius: 0.5,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(9.0)),
                    child: BubbleBackground(
                      colors: [
                        if (isMine)
                          const Color(0xFF6C7689)
                        else
                          const Color(0xFF19B7FF),
                        if (isMine)
                          const Color(0xFF3A364B)
                        else
                          const Color(0xFF491CCB),
                      ],
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 8),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    Key? key,
    required this.colors,
    this.child,
  }) : super(key: key);

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
        scrollable: Scrollable.of(context)!,
        bubbleContext: context,
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({
    required ScrollableState scrollable,
    required BuildContext bubbleContext,
    required List<Color> colors,
  })  : _scrollable = scrollable,
        _bubbleContext = bubbleContext,
        _colors = colors;

  final ScrollableState _scrollable;
  final BuildContext _bubbleContext;
  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    final scrollableBox = _scrollable.context.findRenderObject() as RenderBox?;
    final scrollableRect = Offset.zero & scrollableBox!.size;
    final bubbleBox = _bubbleContext.findRenderObject() as RenderBox?;

    final origin =
        bubbleBox!.localToGlobal(Offset.zero, ancestor: scrollableBox);
    final paint = Paint()
      ..shader = ui.Gradient.linear(
        scrollableRect.topCenter,
        scrollableRect.bottomCenter,
        _colors,
        [0.0, 1.0],
        TileMode.clamp,
        Matrix4.translationValues(-origin.dx, -origin.dy, 0.0).storage,
      );
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    return oldDelegate._scrollable != _scrollable ||
        oldDelegate._bubbleContext != _bubbleContext ||
        oldDelegate._colors != _colors;
  }
}
