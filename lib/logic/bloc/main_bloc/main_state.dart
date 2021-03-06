part of 'main_bloc.dart';

enum CurrentView {
  messages,
  dialog,
  contacts,
  settings,
  security,
  faq,
}

abstract class MainAppState extends Equatable {}

class MainAppLoading extends MainAppState {
  @override
  List<Object> get props => [];
}

class MainAppLoaded extends MainAppState {
  final String uid;
  final String username;
  final Uint8List avatar;
  final int newMessages;
  final int newContactRequests;
  final CurrentView currentView;

  MainAppLoaded({
    required this.uid,
    required this.username,
    required this.avatar,
    this.newMessages = 0,
    this.newContactRequests = 0,
    this.currentView = CurrentView.messages,
  });

  @override
  List<Object> get props => [
        newContactRequests,
        newMessages,
        currentView,
        uid,
        username,
        avatar,
      ];
}

class MainAppNotLoaded extends MainAppState {
  @override
  List<Object> get props => [];
}

class MainAppDialog extends MainAppState {
  final String uid;
  final String username;
  final Uint8List avatar;
  final int newMessages;
  final int newContactRequests;
  final CurrentView currentView;
  final Chatroom chat;

  MainAppDialog({
    required this.uid,
    required this.username,
    required this.avatar,
    this.newMessages = 0,
    this.newContactRequests = 0,
    this.currentView = CurrentView.dialog,
    required this.chat,
  });

  @override
  List<Object> get props => [
        newContactRequests,
        newMessages,
        currentView,
        uid,
        username,
        avatar,
      ];
}
