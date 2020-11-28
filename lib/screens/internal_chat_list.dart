import 'package:flutter/material.dart';
import 'package:void_chat_beta/widgets/build_app_bar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class InternalChatList extends StatefulWidget {
  @override
  _InternalChatListState createState() => _InternalChatListState();
}

class _InternalChatListState extends State<InternalChatList> {
  var data = 'Lol waddup';
  setData(String word) async {
    var box = await Hive.openBox('testbox');
    box.put('name', word);
    data = box.get('name');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Hive.initFlutter();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setData('Fuck this shit i am lhoyt!!');
        },
        child: Icon(Icons.local_activity),
      ),
      appBar: buildAppBar(context),
      body: Container(
        width: size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Text(data),
          ],
        ),
      ),
    );
  }
}
