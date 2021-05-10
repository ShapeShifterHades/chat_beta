part of 'message_bloc.dart';

abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MessageToSend> messages;

  const MessagesLoaded([this.messages = const []]);

  @override
  List<Object> get props => [messages];
}

class MessagesNotLoaded extends MessagesState {}
