part of 'contacts_finduser_bloc.dart';

class ContactsFinduserState {
  final bool? isLoading;
  final Contact? contact;
  final bool? hasError;

  const ContactsFinduserState({this.isLoading, this.contact, this.hasError});

  factory ContactsFinduserState.initial() {
    return const ContactsFinduserState(
      contact: Contact(),
      isLoading: false,
      hasError: false,
    );
  }

  factory ContactsFinduserState.loading() {
    return const ContactsFinduserState(
      contact: Contact(),
      isLoading: true,
      hasError: false,
    );
  }

  factory ContactsFinduserState.success(Contact? contact) {
    return ContactsFinduserState(
      contact: contact,
      isLoading: false,
      hasError: false,
    );
  }

  factory ContactsFinduserState.error() {
    return const ContactsFinduserState(
      contact: Contact(),
      isLoading: false,
      hasError: true,
    );
  }

  @override
  String toString() =>
      'FinduserState {contact: ${contact.toString()}, isLoading: $isLoading, hasError: $hasError }';
}
