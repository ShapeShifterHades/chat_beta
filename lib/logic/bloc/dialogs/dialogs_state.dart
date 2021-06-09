part of 'dialogs_bloc.dart';

abstract class DialogsState extends Equatable {
  const DialogsState();

  @override
  List<Object> get props => [];
}

class ChatroomLoading extends DialogsState {}

class DialogsLoaded extends DialogsState {
  final List<Chatroom> chatrooms;

  const DialogsLoaded([this.chatrooms = const []]);

  @override
  List<Object> get props => [chatrooms];
}

class ChatroomsNotLoaded extends DialogsState {}
