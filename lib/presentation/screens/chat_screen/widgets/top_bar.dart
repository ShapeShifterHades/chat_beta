import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/messages/messages_bloc.dart';
import 'package:void_chat_beta/presentation/screens/chat_screen/chat_view.dart';

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
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/images/avatar-placeholder.png'),
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
            if (newValue == 'Clear history') {
              BlocProvider.of<MessagesBloc>(context)
                  .add(DeleteAllMessages(widget.widget.chat.id));
            }
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
    );
  }
}
