import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/message_bubble.dart';
import 'package:void_chat_beta/presentation/styled_widgets/loading_indicator.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    Key? key,
    required this.chat,
    required this.controller,
  }) : super(key: key);

  final Chatroom chat;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, bottom: 5, right: 5, top: 40.5),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10)),
      child: BlocBuilder<MessageBloc, MessagesState>(
        builder: (context, state) {
          if (state is MessagesLoaded) {
            final messages = state.messages;

            if (messages.isNotEmpty) {
              return ListView.builder(
                controller: controller,
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageBubble(
                    message: messages[index],
                  );
                },
              );
            } else {
              return const LoadingIndicator(
                  text: 'You have no messages yet...');
            }
          }
          {
            return const LoadingIndicator(
              text: 'Loading messages, please wait...',
            );
          }
        },
      ),
    );
  }
}
