import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/main_bloc.dart';
import 'package:void_chat_beta/logic/bloc/messages/messages_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/chat_screen.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/input_board.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/options_bar.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/widgets/top_bar.dart';

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
    BlocProvider.of<MessagesBloc>(context).add(LoadMessages(widget.chat.id));
    super.initState();
  }

  Future<bool> _onWillPop() async {
    if (selectMode) {
      setState(() {
        selectMode = false;
      });

      return false;
    }
    BlocProvider.of<MainAppBloc>(context).add(const SwitchView());
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: NotificationListener<SelectNotification>(
        onNotification: (notification) {
          setState(() {
            selectMode = notification.selectMode;
            selectedArray = [];
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
            return true;
          },
          child: FooterLayout(
            footer: InputBoard(chat: widget.chat, controller: scrollController),
            child: SizedBox.expand(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  _TopBar(
                    selectMode: selectMode,
                    widget: widget,
                    selectedArray: selectedArray,
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
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    Key? key,
    required this.selectMode,
    required this.widget,
    required this.selectedArray,
  }) : super(key: key);

  final bool selectMode;
  final ChatView widget;
  final List<String> selectedArray;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 2,
      left: 40,
      right: 10,
      child: AnimatedSwitcher(
        duration: Times.slow,
        switchInCurve: Curves.bounceIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: !selectMode
            ? TopBar(key: const ValueKey<String>('TopBar'), widget: widget)
            : OptionsBar(
                key: const ValueKey<String>('OptionsBar'),
                selectedArray: selectedArray,
                chat: widget.chat,
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
