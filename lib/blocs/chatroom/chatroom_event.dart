part of 'chatroom_bloc.dart';

abstract class ChatroomEvent extends Equatable {
  const ChatroomEvent();

  @override
  List<Object> get props => [];
}

class LoadChatrooms extends ChatroomEvent {}

class AddChatroom extends ChatroomEvent {
  final Chatroom chatroom;

  const AddChatroom(this.chatroom);

  @override
  List<Object> get props => [chatroom];
}

class UpdateChatroom extends ChatroomEvent {
  final Chatroom updatedChatroom;

  const UpdateChatroom(this.updatedChatroom);

  @override
  List<Object> get props => [updatedChatroom];
}

class DeleteChatroom extends ChatroomEvent {
  final Chatroom chatroom;

  const DeleteChatroom(this.chatroom);

  @override
  List<Object> get props => [chatroom];
}

class ChatroomsUpdated extends ChatroomEvent {
  final List<Chatroom> chatrooms;

  const ChatroomsUpdated(this.chatrooms);

  @override
  List<Object> get props => [chatrooms];
}
