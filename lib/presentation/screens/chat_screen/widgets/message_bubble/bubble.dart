import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/chat_screen.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/bubble_painter.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/labeled_checkbox.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/message_status_dot.dart';

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
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  bool isSelected = false;

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
      child: LabeledCheckbox(
        activate: widget.selectMode,
        onChanged: widget.selectMode
            ? (bool newValue) {
                setState(() {
                  SelectedArray(docId: widget.message.docId!).dispatch(context);
                  isSelected = newValue;
                });
              }
            : (bool newValue) {},
        value: isSelected,
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
            DecoratedBox(
              decoration: BoxDecoration(
                color: isMine
                    ? Theme.of(context).primaryColor
                    : const Color(0xFF202C59),
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).backgroundColor,
                    spreadRadius: 3,
                    blurRadius: 12,
                    offset: const Offset(-0, 1),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: BubbleBackground(
                  colors: isMine
                      ? [const Color(0xFF6C7689), const Color(0xFF3A364B)]
                      : [
                          const Color(0xFF004D40),
                          Colors.teal,
                        ],
                  child: DefaultTextStyle.merge(
                    style: TextStyles.body1
                        .copyWith(color: Theme.of(context).primaryColor),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(bottom: 6.0, left: 6, right: 6),
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
