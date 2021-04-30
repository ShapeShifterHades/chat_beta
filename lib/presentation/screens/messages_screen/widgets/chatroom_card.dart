import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

class ChatroomCard extends StatelessWidget {
  const ChatroomCard({
    Key? key,
    required this.chat,
    this.onPress,
  }) : super(key: key);

  final Chatroom chat;
  final VoidCallback? onPress;
  final bool isActive = false;

  Future<String?> getUsernameById(String? id, BuildContext ctx) async {
    var result;
    try {
      result = await RepositoryProvider.of<FirestoreContactRepository?>(ctx)
          ?.findUsernameById(id);
    } catch (e) {
      print(e);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    String? _userId = getChatroomId(
        chat.name!, BlocProvider.of<AuthenticationBloc>(context).state.user.id);

    return FutureBuilder(
      future: getUsernameById(_userId, context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print(snapshot.data ?? ' fetching username for - $_userId');
          return _Card(
            onPress: onPress,
            username: snapshot.hasData ? snapshot.data as String : 'no data',
            chat: chat,
            isActive: isActive,
          );
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
  })  : _username = username,
        super(key: key);

  final VoidCallback? onPress;
  final String? _username;
  final Chatroom chat;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    String? _dateTop = DateFormat('EEE, MM-dd').format(chat.lastMessageAt!);
    String? _dateBottom = DateFormat('kk:mm').format(chat.lastMessageAt!);
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Opacity(
              opacity: 0.64,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_dateTop, style: TextStyles.body3),
                  Text(_dateBottom, style: TextStyles.body3),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _username ?? ' null',
                      // chat.name!,
                      style: TextStyles.body3,
                    ),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        chat.lastMessage,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.body3,
                      ),
                    ),
                  ],
                ),
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
