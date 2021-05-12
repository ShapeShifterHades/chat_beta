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
      margin: const EdgeInsets.only(left: 4, top: 4),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: _getDotColor(message),
        shape: BoxShape.circle,
      ),
      child: Icon(
        message.timeSent == null ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Color _getDotColor(MessageToSend message) {
    final _sent = message.timeSent;
    final bool _isNew = message.isNew;

    if (_sent == null) {
      return Colors.yellow;
    } else if (_isNew) {
      return const Color(0xFF00695C);
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
    final String time = timeago.format(message.timeSent!).trim();
    return Column(
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
          child:
              Text(message.text! + message.toString(), style: TextStyles.body2),
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
