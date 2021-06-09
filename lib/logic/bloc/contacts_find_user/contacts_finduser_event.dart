part of 'contacts_finduser_bloc.dart';

abstract class ContactsFinduserEvent extends Equatable {
  const ContactsFinduserEvent();

  @override
  List<Object> get props => [];
}

@immutable
class QueryEvent extends ContactsFinduserEvent {
  final String query;

  const QueryEvent(this.query);

  @override
  String toString() => 'FinduserEvent { query: $query }';
}

class ResetEvent extends ContactsFinduserEvent {
  @override
  List<Object> get props => [];
}
