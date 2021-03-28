import 'package:flutter/material.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/found_user_ui.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/user_painter.dart';

class InteractiveSearchUi extends StatelessWidget {
  InteractiveSearchUi({
    Key key,
    @required FocusNode focusNode,
    this.response = 'Enter valid username',
  })  : searchUiHeight = 260.0,
        _focusNode = focusNode,
        super(key: key);

  final FocusNode _focusNode;
  final String response;
  final double searchUiHeight;

  double getSearchHeight() {
    return _focusNode.hasFocus ? searchUiHeight : 0;
  }

  @override
  Widget build(BuildContext context) {
    FirestoreContactRepository _firestoreContactRepository =
        FirestoreContactRepository();

    return Container(
        child: SingleChildScrollView(
      child: Column(
        children: [
          context.watch<SearchUserFormBloc>().username.value.length > 5
              ? FutureBuilder(
                  future: _firestoreContactRepository.findIdByUsername(
                      context.watch<SearchUserFormBloc>().username.value,
                      context.watch<AuthenticationBloc>().state.user.id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                          alignment: Alignment.center,
                          child: Text('No such user'));
                    else if (snapshot.hasData) {
                      Contact result;
                      try {
                        result = snapshot?.data;
                      } catch (e) {
                        print(e);
                      }
                      // switch (context.watch<SearchUserFormBloc>().state)
                      return FoundUserUi(result: result);
                    }
                    return Container(
                      child: Text('No connection with Internet'),
                    );
                  },
                )
              : CustomPaint(
                  painter: SearchUiPainter(context, _focusNode),
                  child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child:
                          Text('Enter username at least 6 charachters long')),
                )
        ],
      ),
    ));
  }
}
