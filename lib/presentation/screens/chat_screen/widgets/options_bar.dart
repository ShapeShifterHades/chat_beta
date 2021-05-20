import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/message/message_bloc.dart';

class OptionsBar extends StatelessWidget {
  const OptionsBar({
    Key? key,
    required this.selectedArray,
    required this.chat,
  }) : super(key: key);

  final List<String> selectedArray;
  final Chatroom chat;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SelectedCounter(selectedArray: selectedArray),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.forward),
          iconSize: 28,
          color: Theme.of(context).primaryColor.withOpacity(0.72),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.reply),
          iconSize: 28,
          color: Theme.of(context).primaryColor.withOpacity(0.72),
        ),
        const SizedBox(width: 6),
        IconButton(
          onPressed: () {
            BlocProvider.of<MessageBloc>(context)
                .add(DeleteSelectedMessages(selectedArray, chat.id));
          },
          icon: const Icon(Icons.delete),
          iconSize: 28,
          color: Theme.of(context).primaryColor.withOpacity(0.72),
        ),
      ],
    );
  }
}

class _SelectedCounter extends StatelessWidget {
  const _SelectedCounter({
    Key? key,
    required this.selectedArray,
  }) : super(key: key);

  final List<String> selectedArray;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: AnimatedSwitcher(
        duration: Times.slow,
        switchInCurve: Curves.bounceIn,
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Text(
          '${selectedArray.length}',
          key: ValueKey<int>(selectedArray.length),
          style: TextStyles.title1,
        ),
      ),
    );
  }
}
