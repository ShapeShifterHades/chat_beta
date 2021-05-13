import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
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

class _ChatViewState extends State<ChatView> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    BlocProvider.of<MessageBloc>(context).add(LoadMessages(widget.chat.id));
    super.initState();
  }

  @override
  void dispose() {
    for (var message in messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: UI(
        body: FooterLayout(
          footer: InputBoard(
              chat: widget.chat,
              controller: scrollController,
              animationController: animationController),
          child: SizedBox.expand(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                TopBar(widget: widget),
                const _ChatBackground(),
                ChatScreen(
                    chat: widget.chat,
                    controller: scrollController,
                    animationController: animationController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  const TopBar({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ChatView widget;

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 2,
        left: 40,
        right: 10,
        child: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage:
                  AssetImage('assets/images/avatar-placeholder.png'),
            ),
            const SizedBox(width: 10),
            Text(widget.widget.chat.username ?? '', style: TextStyles.callout1),
            const Spacer(),
            DropdownButton<String>(
              icon: const Icon(Icons.more_vert),
              iconSize: 28,
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Info',
                'Clear history',
                'Delete chat',
                'Share contact'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyles.body2
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                );
              }).toList(),
            )
          ],
        ));
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
          color: Theme.of(context).primaryColor.withOpacity(0.06),
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
