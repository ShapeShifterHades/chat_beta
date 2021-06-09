part of 'dialogs_bloc.dart';

abstract class DialogsState extends Equatable {
  const DialogsState();

  @override
  List<Object> get props => [];
}

class ChatroomLoading extends DialogsState {}

class ChatroomLoaded extends DialogsState {
  final List<Chatroom> chatrooms;

  const ChatroomLoaded([this.chatrooms = const []]);

  @override
  List<Object> get props => [chatrooms];
}

class ChatroomsNotLoaded extends DialogsState {}
