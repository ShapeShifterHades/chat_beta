import 'dart:async';
import 'dart:core';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

part 'dialogs_event.dart';
part 'dialogs_state.dart';

class DialogsBloc extends Bloc<DialogsEvent, DialogsState> {
  final FirestoreDialogsRepository? _firestoreChatroomRepository;
  final String authId;
  StreamSubscription? _chatroomSubscription;
  DialogsBloc(
      {required FirestoreDialogsRepository? firestoreChatroomRepository,
      required AuthenticationBloc? authenticationBloc})
      : _firestoreChatroomRepository = firestoreChatroomRepository,
        authId = authenticationBloc!.state.user.id,
        super(ChatroomLoading());

  @override
  Stream<DialogsState> mapEventToState(
    DialogsEvent event,
  ) async* {
    if (event is LoadDialogs) {
      yield* _mapLoadChatroomsToState();
    } else if (event is AddDialog) {
      yield* _mapAddChatroomToState(event);
    } else if (event is UpdateDialog) {
      yield* _mapUpdateChatroomToState(event);
    } else if (event is DeleteDialog) {
      yield* _mapDeleteChatroomToState(event);
    } else if (event is DialogsUpdated) {
      yield* _mapChatroomsUpdatedToState(event);
    }
  }

  Stream<DialogsState> _mapLoadChatroomsToState() async* {
    _chatroomSubscription?.cancel();
    _chatroomSubscription = _firestoreChatroomRepository
        ?.chatrooms(authId)
        .listen((chatrooms) => add(DialogsUpdated(chatrooms)));
  }

  Stream<DialogsState> _mapAddChatroomToState(AddDialog event) async* {
    _firestoreChatroomRepository?.addChatroom(event.dialog, authId);
  }

  Stream<DialogsState> _mapUpdateChatroomToState(UpdateDialog event) async* {
    _firestoreChatroomRepository?.updateChatroom(event.updatedDialog, authId);
  }

  Stream<DialogsState> _mapDeleteChatroomToState(DeleteDialog event) async* {
    _firestoreChatroomRepository?.deleteChatroom(event.dialog, authId);
  }

  Stream<DialogsState> _mapChatroomsUpdatedToState(
      DialogsUpdated event) async* {
    yield DialogsLoaded(event.dialogs);
  }

  @override
  Future<void> close() {
    _chatroomSubscription?.cancel();
    return super.close();
  }
}
