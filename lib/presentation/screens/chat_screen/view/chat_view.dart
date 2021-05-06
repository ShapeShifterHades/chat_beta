import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class ChatView extends StatelessWidget {
  final Chatroom? chat;

  const ChatView({Key? key, this.chat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: UI(
        body: FooterLayout(
          footer: _InputBoard(),
          child: Center(
            child: SizedBox.expand(
              child: Container(
                  child: Column(
                children: [
                  Container(
                    height: 35.5,
                    width: double.infinity,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 25, bottom: 5, right: 5, top: 5),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class _InputBoard extends StatelessWidget {
  const _InputBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardAttachable(
      child: Container(
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
                    SizedBox(height: 4),
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
                        SizedBox(width: 25),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            child: Center(
                              child: TextFormField(
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
                          alignment: Alignment(0, 0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send,
                              size: 28,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.82),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
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
