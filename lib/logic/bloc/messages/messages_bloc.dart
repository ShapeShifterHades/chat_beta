import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final FirestoreMessageRepository _firestoreMessageRepository;
  final String authId;
  StreamSubscription? _messagesSubscription;
  MessagesBloc(
      {required FirestoreMessageRepository firestoreMessageRepository,
      required AuthenticationBloc authenticationBloc})
      : _firestoreMessageRepository = firestoreMessageRepository,
        authId = authenticationBloc.state.user.id,
        super(MessagesLoading());

  @override
  Stream<MessagesState> mapEventToState(
    MessagesEvent event,
  ) async* {
    if (event is LoadMessages) {
      yield* _mapLoadMessagesToState(event);
    } else if (event is AddMessage) {
      yield* _mapAddMessageToState(event);
    } else if (event is UpdateMessage) {
      yield* _mapUpdateMessageToState(event);
    } else if (event is DeleteSelectedMessages) {
      yield* _mapDeleteSelectedMessagesToState(event);
    } else if (event is MessagesUpdated) {
      yield* _mapMessagesUpdatedToState(event);
    } else if (event is DeleteAllMessages) {
      yield* _mapDeleteAllMessagesToState(event);
    }
  }

  Stream<MessagesState> _mapLoadMessagesToState(LoadMessages event) async* {
    _messagesSubscription?.cancel();
    _messagesSubscription = _firestoreMessageRepository
        .messages(authId, event.id!)
        .listen((messages) => add(MessagesUpdated(messages)));
  }

  Stream<MessagesState> _mapAddMessageToState(AddMessage event) async* {
    _firestoreMessageRepository.addMessage(
        event.message, authId, event.message.recieverId!);
  }

  Stream<MessagesState> _mapUpdateMessageToState(UpdateMessage event) async* {
    _firestoreMessageRepository.updateMessage(
        event.updatedMessage, authId, event.updatedMessage.recieverId);
  }

  Stream<MessagesState> _mapDeleteSelectedMessagesToState(
      DeleteSelectedMessages event) async* {
    _firestoreMessageRepository.deleteSelectedmessages(
        event.idList, authId, event.interlocutorId);
  }

  Stream<MessagesState> _mapDeleteAllMessagesToState(
      DeleteAllMessages event) async* {
    _firestoreMessageRepository.deleteAllMessages(authId, event.interlocutorId);
  }

  Stream<MessagesState> _mapMessagesUpdatedToState(
      MessagesUpdated event) async* {
    yield MessagesLoaded(event.messages);
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
