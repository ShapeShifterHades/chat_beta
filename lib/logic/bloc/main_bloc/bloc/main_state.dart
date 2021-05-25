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
  final int newMessages;
  final int newContactRequests;
  final CurrentView currentView;

  MainAppLoaded({
    this.newMessages = 0,
    this.newContactRequests = 0,
    this.currentView = CurrentView.messages,
  });

  @override
  List<Object> get props => [newContactRequests, newMessages, currentView];
}

class MainAppNotLoaded extends MainAppState {
  @override
  List<Object> get props => [];
}
