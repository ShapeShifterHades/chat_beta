import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/widgets/chatroom_card.dart';
import 'package:void_chat_beta/presentation/styled_widgets/loading_indicator.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({
    Key? key,
  }) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> _reloadChatrooms() async {
    BlocProvider.of<ChatroomBloc>(context).add(LoadChatrooms());
    refreshKey.currentState?.show(atTop: false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatroomBloc, ChatroomState>(
      builder: (context, state) {
        if (state is ChatroomLoaded) {
          final chats = state.chatrooms;

          if (chats.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 50, left: 25),
              child: RefreshIndicator(
                key: refreshKey,
                onRefresh: () => _reloadChatrooms(),
                child: ListView.builder(
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return ChatroomCard(
                      chat: chats[index],
                      onPress: () {
                        Navigator.of(context)
                            .pushNamed(chatRoute, arguments: chats[index]);
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return const LoadingIndicator(
                text: 'You have no conversations yet...');
          }
        }
        return const LoadingIndicator();
      },
    );
  }
}
