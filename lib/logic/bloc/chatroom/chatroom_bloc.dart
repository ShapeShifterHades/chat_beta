import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

part 'chatroom_event.dart';
part 'chatroom_state.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  final FirestoreChatroomRepository? _firestoreChatroomRepository;
  final String authId;
  StreamSubscription? _chatroomSubscription;
  ChatroomBloc(
      {required FirestoreChatroomRepository? firestoreChatroomRepository,
      required AuthenticationBloc? authenticationBloc})
      : _firestoreChatroomRepository = firestoreChatroomRepository,
        authId = authenticationBloc!.state.user.id,
        super(ChatroomLoading());

  @override
  Stream<ChatroomState> mapEventToState(
    ChatroomEvent event,
  ) async* {
    if (event is LoadChatrooms) {
      yield* _mapLoadChatroomsToState();
    } else if (event is AddChatroom) {
      yield* _mapAddChatroomToState(event);
    } else if (event is UpdateChatroom) {
      yield* _mapUpdateChatroomToState(event);
    } else if (event is DeleteChatroom) {
      yield* _mapDeleteChatroomToState(event);
    } else if (event is ChatroomsUpdated) {
      yield* _mapChatroomsUpdatedToState(event);
    }
  }

  Stream<ChatroomState> _mapLoadChatroomsToState() async* {
    _chatroomSubscription?.cancel();
    _chatroomSubscription = _firestoreChatroomRepository
        ?.chatrooms(authId)
        .listen((chatrooms) => add(ChatroomsUpdated(chatrooms)));
  }

  Stream<ChatroomState> _mapAddChatroomToState(AddChatroom event) async* {
    _firestoreChatroomRepository?.addChatroom(event.chatroom, authId);
  }

  Stream<ChatroomState> _mapUpdateChatroomToState(UpdateChatroom event) async* {
    _firestoreChatroomRepository?.updateChatroom(event.updatedChatroom, authId);
  }

  Stream<ChatroomState> _mapDeleteChatroomToState(DeleteChatroom event) async* {
    _firestoreChatroomRepository?.deleteChatroom(event.chatroom, authId);
  }

  Stream<ChatroomState> _mapChatroomsUpdatedToState(
      ChatroomsUpdated event) async* {
    yield ChatroomLoaded(event.chatrooms);
  }

  @override
  Future<void> close() {
    _chatroomSubscription?.cancel();
    return super.close();
  }
}
