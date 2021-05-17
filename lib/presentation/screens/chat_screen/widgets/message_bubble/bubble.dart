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
    // required this.index,
  }) : super(key: key);

  final MessageToSend message;
  final Widget child;
  // final int index;

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  bool isSelected = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: Times.slower, vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String authId =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    final bool isMine = widget.message.senderId == authId;
    final Alignment messageAlignment =
        isMine ? Alignment.topRight : Alignment.topLeft;
    final String time = (widget.message.timeSent != null)
        ? timeago.format(widget.message.timeSent!)
        : '';

    super.build(context);
    return GestureDetector(
      onLongPress: () {
        setState(() {
          isSelected = !isSelected;
          print(widget.message.docId);
        });
      },
      child: AnimatedContainer(
        duration: Times.fast,
        color: isSelected
            ? Theme.of(context).primaryColor.withOpacity(0.15)
            : Colors.transparent,
        child: AnimatedOpacity(
          duration: Times.slower,
          opacity: animation.value,
          curve: Curves.easeInOutQuart,
          child: AnimatedPadding(
            duration: Times.fast,
            curve: Curves.easeInOutQuart,
            padding: EdgeInsets.only(bottom: 2 * animation.value),
            child: FractionallySizedBox(
              alignment: messageAlignment,
              widthFactor: 0.90,
              child: Align(
                alignment: messageAlignment,
                child: Column(
                  crossAxisAlignment: isMine
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          time,
                          style: TextStyles.body2.copyWith(
                              fontSize: 8,
                              color: Theme.of(context).primaryColor),
                        ),
                        if (isMine) MessageStatusDot(widget.message),
                      ],
                    ),
                    const SizedBox(height: 3),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: isMine
                            ? Theme.of(context).primaryColor
                            : const Color(0xFF202C59),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.3),
                            spreadRadius: 0.5,
                            blurRadius: 0.2,
                            offset: const Offset(
                                -1, 0.4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: DefaultTextStyle.merge(
                        style: TextStyles.body1.copyWith(
                            color: isMine
                                ? const Color(0xFF0B0A07)
                                : Theme.of(context).primaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 8),
                          child: widget.child,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
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
        colors: colors,
      ),
      child: child,
    );
  }
}

class BubblePainter extends CustomPainter {
  BubblePainter({
    required List<Color> colors,
  }) : _colors = colors;

  final List<Color> _colors;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO:
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) {
    // TODO:
    return false;
  }
}
