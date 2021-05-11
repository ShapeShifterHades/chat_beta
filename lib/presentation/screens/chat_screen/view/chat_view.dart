import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/chat_screen.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/input_board.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';

class ChatView extends StatefulWidget {
  final Chatroom chat;

  const ChatView({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<MessageBloc>(context).add(LoadMessages(widget.chat.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: UI(
        body: FooterLayout(
          footer: InputBoard(chat: widget.chat, controller: scrollController),
          child: ChatScreen(chat: widget.chat, controller: scrollController),
        ),
      ),
    );
  }
}
