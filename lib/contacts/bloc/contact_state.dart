part of 'contact_bloc.dart';

enum ContactListStatus { loading, loadedSuccessfully, loadedWithError }

class ContactState extends Equatable {
  final ContactListStatus status;
  final contacts;
  const ContactState._(
      {this.status = ContactListStatus.loading,
      this.contacts = ContactModel.empty});

  const ContactState.loading() : this._();
  const ContactState.loadedSuccessfully(List<ContactModel> contacts)
      : this._(
            status: ContactListStatus.loadedSuccessfully, contacts: contacts);
  const ContactState.loadedWithError() : this._();
  @override
  List<Object> get props => [status, contacts];
}
