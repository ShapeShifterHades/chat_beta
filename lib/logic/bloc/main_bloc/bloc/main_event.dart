part of 'main_bloc.dart';

abstract class MainAppEvent extends Equatable {
  const MainAppEvent();

  @override
  List<Object> get props => [];
}

class LoadMainApp extends MainAppEvent {}

class SwitchView extends MainAppEvent {
  final CurrentView view;

  const SwitchView({this.view = CurrentView.messages});

  @override
  List<Object> get props => [view];
}

class DialogRequested extends MainAppEvent {
  final Chatroom chat;

  const DialogRequested(this.chat);

  @override
  List<Object> get props => [chat];
}

class UpdateNewMessages extends MainAppEvent {
  final int newMessages;

  const UpdateNewMessages(this.newMessages);

  @override
  List<Object> get props => [newMessages];
}

class UpdateNewContacts extends MainAppEvent {
  final int newContacts;

  const UpdateNewContacts(this.newContacts);

  @override
  List<Object> get props => [newContacts];
}
