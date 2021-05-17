import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';

class InputBoard extends StatefulWidget {
  const InputBoard({
    Key? key,
    required this.chat,
    required this.controller,
  }) : super(key: key);
  final Chatroom chat;
  final ScrollController controller;

  @override
  _InputBoardState createState() => _InputBoardState();
}

class _InputBoardState extends State<InputBoard> {
  final TextEditingController _textEditingController = TextEditingController();

  void _sendMessage(String text) {
    if (_textEditingController.value.text.isNotEmpty) {
      // ignore: invalid_use_of_protected_member
      if (widget.controller.positions.isNotEmpty) {
        widget.controller.position.maxScrollExtent;
      }

      final String _authId =
          BlocProvider.of<AuthenticationBloc>(context).state.user.id;
      BlocProvider.of<MessageBloc>(context).add(
        AddMessage(
          MessageToSend(
            isNew: true,
            recieverId: widget.chat.id,
            senderId: _authId,
            text: _textEditingController.value.text,
          ),
        ),
      );
      _textEditingController.clear();
      FocusScope.of(context).unfocus();
      setState(() {});
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAttachable(
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                alignment: Alignment.topCenter,
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    Container(
                      width: 50,
                      alignment: const Alignment(0, 0),
                      child: IconButton(
                        onPressed: () {
                          _sendMessage(_textEditingController.value.text);
                        },
                        icon: Transform.rotate(
                          angle: -1.564,
                          child: Icon(
                            Icons.attachment_outlined,
                            size: 28,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.42),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: Center(
                          child: TextFormField(
                            controller: _textEditingController,
                            style: TextStyles.body1,
                            cursorColor: Theme.of(context).primaryColor,
                            showCursor: true,
                            decoration: InputDecoration(
                              hintText: ' Message',
                              focusColor: Theme.of(context).primaryColor,
                              hintStyle: TextStyles.body1,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 40,
                      alignment: const Alignment(0, 0),
                      child: IconButton(
                        onPressed: () {
                          _sendMessage(_textEditingController.value.text);
                        },
                        icon: Icon(
                          Icons.send,
                          size: 28,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.42),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
