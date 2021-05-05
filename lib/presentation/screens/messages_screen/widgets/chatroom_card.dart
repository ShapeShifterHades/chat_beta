import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:async/async.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
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
  String? _interlocutorUsername;
  final bool isActive = false;
  final AsyncMemoizer _memoizer = AsyncMemoizer();
  late String myId;

  Future<String?> getUsernameById(String? id, BuildContext ctx) async {
    var result;
    this._memoizer.runOnce(() async {
      try {
        result = await RepositoryProvider.of<FirestoreContactRepository?>(ctx)
            ?.findUsernameById(id);
      } catch (e) {
        print(e);
      }
      return result;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myId = BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    print(myId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUsernameById(_interlocutorUsername, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          _interlocutorUsername =
              getInterlocutorUsernameFromChat(widget.chat, myId);
          return _Card(
              onPress: widget.onPress,
              username: _interlocutorUsername,
              chat: widget.chat,
              isActive: isActive,
              lastMessageFromYou: widget.chat.lastMessageFrom == myId);
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    Key? key,
    required this.onPress,
    required String? username,
    required this.chat,
    required this.isActive,
    required this.lastMessageFromYou,
  })  : _username = username,
        super(key: key);

  final VoidCallback? onPress;
  final String? _username;
  final Chatroom chat;
  final bool isActive;
  final bool lastMessageFromYou;

  @override
  Widget build(BuildContext context) {
    // String? _dateTop = DateFormat('EEE, MM-dd').format(chat.lastMessageAt!);
    String? _dateBottom = DateFormat('kk:mm').format(chat.lastMessageAt!);
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Opacity(
                          opacity: 0.64,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_dateBottom, style: TextStyles.body3),
                              // Text(_dateTop, style: TextStyles.body3),
                            ],
                          ),
                        ),
                        Text(
                          _username ?? ' null',
                          // chat.name!,
                          style: TextStyles.body3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 30,
                    // width: 100,
                    child: Row(
                      children: [
                        if (lastMessageFromYou)
                          Text('You: ', style: TextStyles.body2),
                        Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Opacity(
                            opacity: 0.64,
                            child: Text(
                              'Message text',
                              // chat.lastMessage,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.body3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                CircleAvatar(
                  radius: 24,
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
          ],
        ),
      ),
    );
  }
}
