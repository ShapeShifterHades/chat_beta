import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageToSend message;

  @override
  Widget build(BuildContext context) {
    final String authId =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    final bool isMe = message.senderId == authId;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 6, right: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          TextMessage(message: message),
          if (isMe) MessageStatusDot(message)
        ],
      ),
    );
  }
}

class MessageStatusDot extends StatelessWidget {
  final MessageToSend message;

  const MessageStatusDot(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 3),
      height: 12,
      width: 12,
      decoration: const BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Icon(
              message.timeSent == null ? Icons.update : Icons.done,
              size: 10,
              color: _getDotColor(message),
            ),
          ),
          if (message.isNew && message.timeSent != null)
            Positioned(
              left: -3,
              top: 1,
              child: Icon(
                Icons.done,
                size: 10,
                color: _getDotColor(message),
              ),
            ),
        ],
      ),
    );
  }

  Color _getDotColor(MessageToSend message) {
    final _sent = message.timeSent;
    final bool _isNew = message.isNew;

    if (_sent == null) {
      return Colors.yellow;
    } else if (_isNew == true) {
      return Colors.lightGreen;
    }
    return Colors.transparent;
  }
}

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final MessageToSend message;

  @override
  Widget build(BuildContext context) {
    final String authId =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    final bool isMe = message.senderId == authId;
    final String time = (message.timeSent != null)
        ? timeago.format(message.timeSent!).trim()
        : '';
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).primaryColor.withOpacity(0.15)
                    : Theme.of(context).splashColor.withRed(100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(message.text!,
                  textWidthBasis: TextWidthBasis.longestLine,
                  style: TextStyles.body2),
            ),
          ],
        ),
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
              child: Text(
                time,
                textAlign: TextAlign.end,
                style: TextStyles.body3.copyWith(
                    fontSize: 8,
                    color: Theme.of(context).primaryColor.withOpacity(0.64)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
