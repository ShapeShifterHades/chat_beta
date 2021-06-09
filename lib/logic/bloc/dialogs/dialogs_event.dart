part of 'dialogs_bloc.dart';

abstract class DialogsEvent extends Equatable {
  const DialogsEvent();

  @override
  List<Object> get props => [];
}

class LoadDialogs extends DialogsEvent {}

class AddDialog extends DialogsEvent {
  final Chatroom dialog;

  const AddDialog(this.dialog);

  @override
  List<Object> get props => [dialog];
}

class UpdateDialog extends DialogsEvent {
  final Chatroom updatedDialog;

  const UpdateDialog(this.updatedDialog);

  @override
  List<Object> get props => [updatedDialog];
}

class DeleteDialog extends DialogsEvent {
  final Chatroom dialog;

  const DeleteDialog(this.dialog);

  @override
  List<Object> get props => [dialog];
}

class DialogsUpdated extends DialogsEvent {
  final List<Chatroom> dialogs;

  const DialogsUpdated(this.dialogs);

  @override
  List<Object> get props => [dialogs];
}
