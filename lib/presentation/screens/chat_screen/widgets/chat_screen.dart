import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_bubble/bubble.dart';
import 'package:void_chat_beta/presentation/styled_widgets/loading_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
    required this.chat,
    required this.controller,
  }) : super(key: key);

  final Chatroom chat;
  final ScrollController controller;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> selectedArray = [];
  bool selectMode = false;

  @override
  Widget build(BuildContext context) {
    final String authId =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    return NotificationListener<SelectedArray>(
      onNotification: (notification) {
        if (selectedArray.contains(notification.docId)) {
          selectedArray.remove(notification.docId);
        } else {
          selectedArray.add(notification.docId);
        }
        print(selectedArray);
        return true;
      },
      child: NotificationListener<SelectNotification>(
        onNotification: (notification) {
          print('BAM!');
          setState(() {
            selectMode = notification.selectMode;
          });
          return selectMode;
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 34, bottom: 5, top: 53.5, right: 12),
          child: BlocBuilder<MessageBloc, MessagesState>(
            builder: (context, state) {
              if (state is MessagesLoaded) {
                final messages = state.messages;
                if (messages.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    controller: widget.controller,
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      if (message.isNew && message.recieverId == authId) {
                        return FutureBuilder<void>(
                            future: FirestoreMessageRepository.markAsRead(
                              message.docId!,
                              message.senderId!,
                              message.recieverId!,
                            ),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return Container(
                                  color: Colors.white,
                                  child: MessageBubble(
                                    selectMode: selectMode,
                                    message: message,
                                    child: Text(
                                      messages[index].text!,
                                    ),
                                  ),
                                );
                              }
                              return MessageBubble(
                                selectMode: selectMode,
                                message: message,
                                child: Text(
                                  messages[index].text!,
                                ),
                              );
                            });
                      }
                      return MessageBubble(
                        selectMode: selectMode,
                        message: message,
                        child: Text(
                          messages[index].text!,
                        ),
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
        ),
      ),
    );
  }
}

class SelectNotification extends Notification {
  final bool selectMode;

  const SelectNotification({this.selectMode = false});
}

class SelectedArray extends Notification {
  final String docId;

  const SelectedArray({this.docId = ''});
}
