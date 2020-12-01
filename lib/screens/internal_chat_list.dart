import 'package:flutter/material.dart';

import 'package:void_chat_beta/widgets/build_app_bar.dart';

class InternalChatList extends StatefulWidget {
  @override
  _InternalChatListState createState() => _InternalChatListState();
}

class _InternalChatListState extends State<InternalChatList> {
  @override
  void initState() {
    super.initState();
  }

  submitTest() async {
    // _message.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          submitTest();
        },
        child: Icon(Icons.local_activity),
      ),
      appBar: buildAppBar(context),
      // body: ValueListenableBuilder(
      //   valueListenable: Hive.box<Message>('messages').listenable(),
      //   builder: (context, Box<Message> box, _) {
      //     if (box.values.isEmpty)
      //       return Center(
      //         child: Text("There is no conversations yet"),
      //       );
      //     return ListView.builder(
      //       // here comes main part, where we get the data count, and builder for data showcase
      //       itemCount: box.values.length,
      //       itemBuilder: (context, index) {
      //         Message data = box.getAt(
      //             index); // use simpleton called data of type Todo from a box with current index.
      //         return ListTile(
      //             title: Text(data.username == null ? '' : data.username),
      //             subtitle: Text(data.text == null
      //                 ? ''
      //                 : 'here will be part of the last message'),
      //             leading: Icon(Icons.person_outline),
      //             onTap: () {
      //               print('go to chat screen');
      //             });
      //       },
      //     );
      //   },
      // ),
    );
  }
}
