import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/sqf/bloc/contact_bloc.dart';
import 'package:void_chat_beta/sqf/bloc/contact_bloc_old.dart';
import 'package:void_chat_beta/sqf/model/contact_model.dart';
import 'package:void_chat_beta/ui/portrait_mobile_ui.dart';

ContactModel contactModel1 = ContactModel(name: 'Popka', status: 'boy');

class ContactsView extends StatelessWidget {
  final ContactBlocOld contactBlocOld = ContactBlocOld();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => contactBlocOld.addContact(contactModel1),
      ),
      body: PortraitMobileUI(
        routeName: 'Contacts',
        content: Container(
          color: Colors.amber.withOpacity(0.2),
          child: Column(
            children: [
              Container(
                child: StreamBuilder<List<ContactModel>>(
                  stream: contactBlocOld.contacts,
                  builder:
                      (context, AsyncSnapshot<List<ContactModel>> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data.length > 0
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, itemPosition) {
                                  ContactModel _contact =
                                      snapshot.data[itemPosition];
                                  return Text(
                                    _contact.status +
                                        ' ' +
                                        _contact.id.toString() +
                                        ' ' +
                                        _contact.name,
                                    style: TextStyle(color: Colors.white),
                                  );
                                },
                              ),
                            )
                          : Text(
                              'No data yet',
                              style: TextStyle(color: Colors.white),
                            );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              BlocBuilder<ContactBloc, ContactState>(
                builder: (context, state) {
                  return Container(
                      child: Text(
                    context.watch<ContactBloc>().state.props.length.toString(),
                    style: TextStyle(color: Colors.white),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
