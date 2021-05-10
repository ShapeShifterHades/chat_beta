import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/input_board.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/message_list.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';

class ChatView extends StatelessWidget {
  final Chatroom? chat;

  const ChatView({Key? key, this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final String authId =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            BlocProvider.of<MessageBloc>(context).add(AddMessage(MessageToSend(
          text: 'This is a step to victory!',
          senderId: authId,
          recieverId: chat?.id,
          timeSent: DateTime.now(),
        ))),
      ),
      resizeToAvoidBottomInset: false,
      body: UI(
        body: FooterLayout(
          footer: const InputBoard(),
          child: Center(
            child: SizedBox.expand(
              child: Column(
                children: [
                  const SizedBox(
                    height: 35.5,
                    width: double.infinity,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 25, bottom: 5, right: 5, top: 5),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(10)),
                      child: MessageList(chat: chat),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
