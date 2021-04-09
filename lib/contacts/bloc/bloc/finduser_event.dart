part of 'finduser_bloc.dart';

@immutable
class FinduserEvent {
  final String query;

  const FinduserEvent(this.query);

  @override
  String toString() => 'FinduserEvent { query: $query }';
}
