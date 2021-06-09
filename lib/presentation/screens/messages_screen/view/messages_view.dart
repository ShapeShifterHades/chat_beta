import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:void_chat_beta/logic/bloc/dialogs/dialogs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/main_bloc.dart';
import 'package:void_chat_beta/presentation/screens/messages_screen/widgets/chatroom_card.dart';
import 'package:void_chat_beta/presentation/styled_widgets/loading_indicator.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({
    Key? key,
  }) : super(key: key);

  @override
  _MessagesViewState createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final GlobalKey<RefreshIndicatorState> refreshKey =
      GlobalKey<RefreshIndicatorState>();
  Future<void> _reloadChatrooms() async {
    BlocProvider.of<DialogsBloc>(context).add(LoadDialogs());
    refreshKey.currentState?.show(atTop: false);
  }

  @override
  Widget build(BuildContext context) {
    final chats =
        (context.watch<DialogsBloc>().state as ChatroomLoaded).chatrooms;

    if (chats.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 40, left: 25, right: 4),
        child: RefreshIndicator(
            key: refreshKey,
            onRefresh: () => _reloadChatrooms(),
            child: Provider.of<ListView>(context)),
      );
    } else {
      return const LoadingIndicator(text: 'You have no conversations yet...');
    }
  }
}

class AvatarBuilder extends StatefulWidget {
  final int index;
  const AvatarBuilder({
    Key? key,
    required this.index,
    required this.chats,
  }) : super(key: key);

  final List<Chatroom> chats;

  @override
  _AvatarBuilderState createState() => _AvatarBuilderState();
}

class _AvatarBuilderState extends State<AvatarBuilder> {
  late Future<String> avatarFuture;

  Future<String> getAvatarUrl(String id) async {
    final String link =
        await RepositoryProvider.of<FirestoreHelperRepository>(context)
            .getAvatarLink(id);

    final String result =
        await RepositoryProvider.of<FirebaseStorageRepository>(context)
            .getAvatarUrlByLink(link);

    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    avatarFuture = getAvatarUrl(widget.chats[widget.index].id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureProvider<String>(
      initialData:
          'https://firebasestorage.googleapis.com/v0/b/voidchatbeta.appspot.com/o/default%2Favatar-placeholder.png?alt=media&token=c6069596-e44d-4091-a659-9f3917ddbab2',
      lazy: false,
      create: (_) => avatarFuture,
      child: ChatroomCard(
        key: Key('chatCard${widget.index}'),
        chat: widget.chats[widget.index],
        onPress: () => BlocProvider.of<MainAppBloc>(context)
            .add(DialogRequested(widget.chats[widget.index])),
      ),
    );
  }
}
