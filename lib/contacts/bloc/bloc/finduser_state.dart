part of 'finduser_bloc.dart';

class FinduserState {
  final bool isLoading;
  final Contact contact;
  final bool hasError;

  const FinduserState({this.isLoading, this.contact, this.hasError});

  factory FinduserState.initial() {
    return FinduserState(
      contact: Contact(),
      isLoading: false,
      hasError: false,
    );
  }

  factory FinduserState.loading() {
    return FinduserState(
      contact: Contact(),
      isLoading: true,
      hasError: false,
    );
  }

  factory FinduserState.success(Contact contact) {
    return FinduserState(
      contact: contact,
      isLoading: false,
      hasError: false,
    );
  }

  factory FinduserState.error() {
    return FinduserState(
      contact: Contact(),
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'FinduserState {contact: ${contact.toString()}, isLoading: $isLoading, hasError: $hasError }';
}
