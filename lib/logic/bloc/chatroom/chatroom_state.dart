part of 'chatroom_bloc.dart';

abstract class ChatroomState extends Equatable {
  const ChatroomState();

  @override
  List<Object> get props => [];
}

class ChatroomLoading extends ChatroomState {}

class ChatroomLoaded extends ChatroomState {
  final List<Chatroom> chatrooms;

  const ChatroomLoaded([this.chatrooms = const []]);

  @override
  List<Object> get props => [chatrooms];
}

class ChatroomsNotLoaded extends ChatroomState {}
