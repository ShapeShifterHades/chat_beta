part of 'searchuser_cubit.dart';

class SearchUsernameState extends Equatable {
  const SearchUsernameState({
    this.username = const Username.pure(),
    this.status = FormzStatus.pure,
  });

  final Username username;
  final FormzStatus status;

  @override
  List<Object> get props => [username, status];

  SearchUsernameState copyWith({
    Username username,
    FormzStatus status,
  }) {
    return SearchUsernameState(
      status: status ?? this.status,
      username: username ?? this.username,
    );
  }
}
