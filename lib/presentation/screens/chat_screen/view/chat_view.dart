import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/chat_screen.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/input_board.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/options_bar.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/top_bar.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';

class ChatView extends StatefulWidget {
  final Chatroom chat;

  const ChatView({Key? key, required this.chat}) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  bool selectMode = false;
  List<String> selectedArray = [];

  @override
  void initState() {
    BlocProvider.of<MessageBloc>(context).add(LoadMessages(widget.chat.id));
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (selectMode) {
      setState(() {
        selectMode = false;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: UI(
          body: NotificationListener<SelectNotification>(
            onNotification: (notification) {
              setState(() {
                selectMode = notification.selectMode;
              });
              return selectMode;
            },
            child: NotificationListener<SelectedArray>(
              onNotification: (notification) {
                if (selectedArray.contains(notification.docId)) {
                  selectedArray.remove(notification.docId);
                } else {
                  selectedArray.add(notification.docId);
                }
                setState(() {});
                print(selectedArray);
                return true;
              },
              child: FooterLayout(
                footer:
                    InputBoard(chat: widget.chat, controller: scrollController),
                child: SizedBox.expand(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 2,
                        left: 40,
                        right: 10,
                        child: AnimatedSwitcher(
                          duration: Times.slow,
                          switchInCurve: Curves.bounceIn,
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: !selectMode
                              ? TopBar(
                                  key: const ValueKey<String>('TopBar'),
                                  widget: widget)
                              : OptionsBar(
                                  key: const ValueKey<String>('OptionsBar'),
                                  selectedArray: selectedArray,
                                  chat: widget.chat,
                                ),
                        ),
                      ),
                      const _ChatBackground(),
                      ChatScreen(
                        chat: widget.chat,
                        controller: scrollController,
                        selectMode: selectMode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatBackground extends StatelessWidget {
  const _ChatBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        margin: const EdgeInsets.only(left: 25, bottom: 2, right: 5, top: 50.5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color(0xff141414),
            ),
            BoxShadow(
              color: Color(0xff303030),
              spreadRadius: -1.0,
              blurRadius: 4.0,
            ),
          ],
        ),
        // child: SvgBackground(),
      ),
    );
  }
}
