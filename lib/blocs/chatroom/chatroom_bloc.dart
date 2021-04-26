import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chatroom_event.dart';
part 'chatroom_state.dart';

class ChatroomBloc extends Bloc<ChatroomEvent, ChatroomState> {
  final FirestoreChatroomRepository _firestoreChatroomRepository;
  StreamSubscription _chatroomSubscription;
  ChatroomBloc(
      {@required FirestoreChatroomRepository firestoreChatroomRepository})
      : _firestoreChatroomRepository = firestoreChatroomRepository,
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
        .chatrooms()
        .listen((chatrooms) => add(ChatroomsUpdated(chatrooms)));
  }

  Stream<ChatroomState> _mapAddChatroomToState(AddChatroom event) async* {
    _firestoreChatroomRepository.addChatroom(event.chatroom);
  }

  Stream<ChatroomState> _mapUpdateChatroomToState(UpdateChatroom event) async* {
    _firestoreChatroomRepository.updateChatroom(event.updatedChatroom);
  }

  Stream<ChatroomState> _mapDeleteChatroomToState(DeleteChatroom event) async* {
    _firestoreChatroomRepository.deleteChatroom(event.chatroom);
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
