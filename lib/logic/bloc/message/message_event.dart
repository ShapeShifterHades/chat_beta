part of 'message_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class LoadMessages extends MessagesEvent {
  final String? id;

  const LoadMessages(this.id);

  @override
  List<Object> get props => [id!];
}

class AddMessage extends MessagesEvent {
  final MessageToSend message;

  const AddMessage(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateMessage extends MessagesEvent {
  final MessageToSend updatedMessage;

  const UpdateMessage(this.updatedMessage);

  @override
  List<Object> get props => [updatedMessage];
}

class DeleteSelectedMessages extends MessagesEvent {
  final List<String> idList;
  final String interlocutorId;

  const DeleteSelectedMessages(this.idList, this.interlocutorId);

  @override
  List<Object> get props => [idList];
}

class DeleteAllMessages extends MessagesEvent {
  final String interlocutorId;

  const DeleteAllMessages(this.interlocutorId);

  @override
  List<Object> get props => [interlocutorId];
}

class MessagesUpdated extends MessagesEvent {
  final List<MessageToSend> messages;

  const MessagesUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}
