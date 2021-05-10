import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

/// Card, that represents brief tile of users conversation in database.
///
/// It uses stream, provided by [ChatroomBloc] and memoize result of a future
/// of getting username.
class ChatroomCard extends StatefulWidget {
  const ChatroomCard({
    Key? key,
    required this.chat,
    this.onPress,
  }) : super(key: key);

  final Chatroom chat;
  final VoidCallback? onPress;

  @override
  _ChatroomCardState createState() => _ChatroomCardState();
}

class _ChatroomCardState extends State<ChatroomCard> {
  final bool isActive = false;
  late String myId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myId = BlocProvider.of<AuthenticationBloc>(context).state.user.id;
  }

  @override
  Widget build(BuildContext context) {
    return _Card(
      onPress: widget.onPress,
      chat: widget.chat,
      isActive: isActive,
      lastMessageFromYou: myId == (widget.chat.lastMessageFrom ?? ''),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.onPress,
    required this.chat,
    this.isActive = false,
    this.lastMessageFromYou = false,
  }) : super(key: key);

  final VoidCallback? onPress;
  final Chatroom chat;
  final bool isActive;
  final bool lastMessageFromYou;
  @override
  Widget build(BuildContext context) {
    // Last message time, if empty - chatroom creation time.
    final String _dateBottom = (chat.lastMessageAt != null)
        ? DateFormat('kk:mm').format(chat.lastMessageAt!)
        : DateFormat('kk:mm').format(chat.createdAt!);
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(_dateBottom, style: TextStyles.callout1),
                        ],
                      ),
                      Text(
                        chat.username!,
                        style: TextStyles.callout1,
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (lastMessageFromYou)
                      Text('You: ', style: TextStyles.body3),
                    Expanded(
                      child: Opacity(
                        opacity: 0.64,
                        child: Text(
                          chat.lastMessage ?? "Conversation is empty.",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.body3,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 60,
            height: 60,
            alignment: Alignment.center,
            child: Stack(
              children: [
                const CircleAvatar(
                  radius: 25,
                  // backgroundImage: AssetImage(),
                ),
                if (isActive)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
