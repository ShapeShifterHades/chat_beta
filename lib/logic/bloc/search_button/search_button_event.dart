part of 'search_button_bloc.dart';

@immutable
abstract class SearchButtonEvent extends Equatable {
  const SearchButtonEvent();

  @override
  List<Object> get props => [];
}

class FinduserStateChanged extends SearchButtonEvent {
  const FinduserStateChanged(this.finduserState);

  final ContactsFinduserState finduserState;

  ContactsFinduserState get state => finduserState;

  @override
  List<Object> get props => [
        finduserState,
      ];
}

class SearchButtonResetEvent extends SearchButtonEvent {
  @override
  List<Object> get props => [];
}
