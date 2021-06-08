import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/widgets/profile_picture.dart';

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

class _ChatroomCardState extends State<ChatroomCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final bool isActive = false;
  late String myId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myId = BlocProvider.of<AuthenticationBloc>(context).state.user.id;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _Card(
      key: Key('card${widget.chat.id}'),
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
        : '';
    return GestureDetector(
      onTap: onPress,
      child: Material(
        elevation: 6,
        shadowColor: Theme.of(context).scaffoldBackgroundColor,
        clipBehavior: Clip.hardEdge,
        shape: BeveledRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.4),
                width: 0.3),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            ProfilePicture(chat: chat, isActive: isActive),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        chat.username!,
                        style: TextStyles.callout1.copyWith(fontSize: 16),
                      ),
                      const Spacer(),
                      Text(_dateBottom, style: TextStyles.callout1),
                    ],
                  ),
                  Divider(
                    height: 0.5,
                    color: Theme.of(context).primaryColor.withOpacity(0.4),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (lastMessageFromYou)
                        Opacity(
                            opacity: 0.64,
                            child: Text('You: ', style: TextStyles.body3)),
                      Expanded(
                        child: Opacity(
                          opacity: 0.64,
                          child: Text(
                            // '${chat.newMessages ?? 0}
                            '${chat.lastMessage}'
                            //  ??   "Conversation is empty. ",
                            ,
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
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
