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
  final Message message;

  const AddMessage(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateMessage extends MessagesEvent {
  final Message updatedMessage;

  const UpdateMessage(this.updatedMessage);

  @override
  List<Object> get props => [updatedMessage];
}

class DeleteMessage extends MessagesEvent {
  final Message message;

  const DeleteMessage(this.message);

  @override
  List<Object> get props => [message];
}

class MessagesUpdated extends MessagesEvent {
  final List<Message> messages;

  const MessagesUpdated(this.messages);

  @override
  List<Object> get props => [messages];
}
