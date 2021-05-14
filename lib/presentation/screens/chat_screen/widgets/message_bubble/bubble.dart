import 'dart:ui' as ui;

import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/message_status_dot.dart';

enum MessageOwner { myself, other }

@immutable
class MessageBubble extends StatefulWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.child,
    required this.index,
  }) : super(key: key);

  final MessageToSend message;
  final Widget child;
  final int index;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with AutomaticKeepAliveClientMixin {
  late bool _animate;
  static late bool _isStart;

  late final String authId;
  late final bool isMine;
  late final Alignment messageAlignment;
  late final String time;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _animate = false;
    _isStart = true;
    authId = BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    isMine = widget.message.senderId == authId;
    messageAlignment = isMine ? Alignment.topRight : Alignment.topLeft;
    time = (widget.message.timeSent != null)
        ? timeago.format(widget.message.timeSent!).trim()
        : '';

    _isStart
        ? mounted
            ? Future.delayed(Times.fast, () {
                setState(() {
                  _animate = true;
                  _isStart = false;
                });
              })
            : null
        : _animate = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FractionallySizedBox(
      alignment: messageAlignment,
      widthFactor: 0.90,
      child: Align(
        alignment: messageAlignment,
        child: AnimatedOpacity(
          duration: Times.slow,
          opacity: _animate ? 1 : 0,
          curve: Curves.easeInOutQuart,
          child: AnimatedPadding(
            duration: Times.fast,
            padding: _animate
                ? const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0)
                : const EdgeInsets.only(bottom: 20),
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
                    if (isMine) MessageStatusDot(widget.message),
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
                          const Color(0xFF393d3f)
                        else
                          const Color(0xFF19B7FF),
                        if (isMine)
                          const Color(0xFF393d3f)
                        else
                          const Color(0xFF003459),
                      ],
                      child: DefaultTextStyle.merge(
                        style: const TextStyle(
                          fontSize: 12.0,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 8),
                          child: widget.child,
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
