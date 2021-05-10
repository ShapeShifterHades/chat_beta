import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';
import 'package:void_chat_beta/presentation/styled_widgets/loading_indicator.dart';

class MessageList extends StatefulWidget {
  const MessageList({
    Key? key,
    this.chat,
  }) : super(key: key);

  final Chatroom? chat;

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MessageBloc>(context).add(LoadMessages(widget.chat?.id));
    return BlocBuilder<MessageBloc, MessagesState>(
      builder: (context, state) {
        if (state is MessagesLoaded) {
          final messages = state.messages;

          if (messages.isNotEmpty) {
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageCard(
                  message: messages[index],
                  onPress: () {},
                );
              },
            );
          } else {
            return const LoadingIndicator(text: 'You have no messages yet...');
          }
        }
        {
          return const LoadingIndicator(
            text: 'Loading messages, please wait...',
          );
        }
      },
    );
  }
}

class MessageCard extends StatelessWidget {
  final MessageToSend? message;
  final VoidCallback? onPress;

  const MessageCard({Key? key, this.message, this.onPress}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(message?.text ?? '');
  }
}
