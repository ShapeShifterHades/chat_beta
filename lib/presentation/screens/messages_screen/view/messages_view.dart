import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/constants.dart';
import 'package:void_chat_beta/logic/bloc/chatroom/chatroom_bloc.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/widgets/chatroom_card.dart';
import 'package:void_chat_beta/presentation/styled_widgets/loading_indicator.dart';

class MessagesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: UI(
        body: MessagesContent(),
      ),
    );
  }
}

class MessagesContent extends StatefulWidget {
  const MessagesContent({
    Key? key,
  }) : super(key: key);

  @override
  _MessagesContentState createState() => _MessagesContentState();
}

class _MessagesContentState extends State<MessagesContent> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
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

          if (chats.length > 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 20, left: 5),
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
          } else
            return LoadingIndicator(text: 'You have no conversations yet...');
        }
        return LoadingIndicator();
      },
    );
  }
}
