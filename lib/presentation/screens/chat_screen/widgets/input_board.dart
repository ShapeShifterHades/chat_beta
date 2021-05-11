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
      widget.controller.position.maxScrollExtent;
      _textEditingController.clear();
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardAttachable(
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(0.64),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(0.64),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 25),
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
                                  hintText: '    Enter message',
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
                          child: Transform.translate(
                            offset: const Offset(0, 1.5),
                            child: IconButton(
                              onPressed: () {
                                _sendMessage(_textEditingController.value.text);
                              },
                              icon: Icon(
                                Icons.send,
                                size: 28,
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.62),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
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
