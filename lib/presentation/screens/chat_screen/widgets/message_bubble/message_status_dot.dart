import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';

class MessageStatusDot extends StatelessWidget {
  final MessageToSend message;

  const MessageStatusDot(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      height: 12,
      width: 12,
      decoration: const BoxDecoration(
        color: Colors.black,
        // shape: BoxShape.circle,
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
          // Container(
          //   width: 16,
          //   height: 16,
          //   color: Colors.black,
          // ),
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
