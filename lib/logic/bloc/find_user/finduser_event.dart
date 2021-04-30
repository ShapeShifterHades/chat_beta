part of 'finduser_bloc.dart';

abstract class FinduserEvent extends Equatable {
  const FinduserEvent();

  @override
  List<Object> get props => [];
}

@immutable
class QueryEvent extends FinduserEvent {
  final String query;

  const QueryEvent(this.query);

  @override
  String toString() => 'FinduserEvent { query: $query }';
}

class ResetEvent extends FinduserEvent {
  @override 
  List<Object> get props => [];
}