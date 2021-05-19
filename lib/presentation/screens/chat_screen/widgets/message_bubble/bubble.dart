import 'dart:ui' as ui;

import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/chat_screen.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/message_status_dot.dart';

enum MessageOwner { myself, other }

@immutable
class MessageBubble extends StatefulWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.child,
    this.selectMode = false,
  }) : super(key: key);

  final MessageToSend message;
  final Widget child;
  final bool selectMode;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool isSelected = false;
  GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final String authId =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    final bool isMine = widget.message.senderId == authId;
    final String time = (widget.message.timeSent != null)
        ? timeago.format(widget.message.timeSent!)
        : '';

    super.build(context);
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isSelected = !isSelected;
          SelectNotification(selectMode: !widget.selectMode).dispatch(context);
          SelectedArray(docId: widget.message.docId!).dispatch(context);

          print(widget.selectMode);
        });
      },
      onTap: () {
        setState(() {
          _key.currentState?.activate();
        });
      },
      child: AnimatedContainer(
        // this one is not used now, but ought to be used for new message color fading out on read
        duration: Times.slow,
        color: Colors.transparent,
        child: Row(
          children: [
            AnimatedContainer(
              margin: const EdgeInsets.only(right: 10),
              duration: Times.fast,
              width: widget.selectMode ? 20 : 0,
              height: 30,
              child: Checkbox(
                key: _key,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                fillColor: MaterialStateProperty.resolveWith(getColor),
                side: BorderSide(
                  width: 0.4,
                  color: Theme.of(context).primaryColor,
                ),
                value: isSelected,
                onChanged: (bool? value) {
                  SelectedArray(docId: widget.message.docId!).dispatch(context);
                  setState(() {
                    isSelected = value!;
                  });
                },
              ),
            ),
            Expanded(
              flex: 9,
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
                            fontSize: 8, color: Theme.of(context).primaryColor),
                      ),
                      if (isMine) MessageStatusDot(widget.message),
                    ],
                  ),
                  const SizedBox(height: 3),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: BubbleBackground(
                      colors: isMine
                          ? [const Color(0xFF6C7689), const Color(0xFF3A364B)]
                          : [
                              const Color(0xFFffffff),
                              const Color(0xFF19B7FF),
                            ],
                      // decoration: BoxDecoration(
                      //   color: isMine
                      //       ? Theme.of(context).primaryColor
                      //       : const Color(0xFF202C59),
                      //   borderRadius:
                      //       const BorderRadius.all(Radius.circular(10)),
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color:
                      //           Theme.of(context).primaryColor.withOpacity(0.3),
                      //       spreadRadius: 0.5,
                      //       blurRadius: 0.2,
                      //       offset: const Offset(
                      //           -1, 0.4), // changes position of shadow
                      //     ),
                      //   ],
                      // ),
                      child: DefaultTextStyle.merge(
                        style: TextStyles.body1.copyWith(
                          color: isMine
                              ? Theme.of(context).primaryColor
                              : const Color(0xFF0B0A07),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 8),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return const Color(0xFF19B7FF);
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
    final scrollableBox = _scrollable.context.findRenderObject()! as RenderBox;
    final scrollableRect = Offset.zero & scrollableBox.size;
    final bubbleBox = _bubbleContext.findRenderObject()! as RenderBox;

    final origin =
        bubbleBox.localToGlobal(Offset.zero, ancestor: scrollableBox);
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
    return true;
    // oldDelegate._scrollable != _scrollable ||
    //     oldDelegate._bubbleContext != _bubbleContext ||
    //     oldDelegate._colors != _colors;
  }
}
