import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/authentication/bloc/authentication_bloc.dart';
import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
import 'package:void_chat_beta/contacts/widgets/searchbar/search_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firestore_repository/firestore_repository.dart';

class InteractiveSearchUi extends StatelessWidget {
  InteractiveSearchUi({
    Key key,
    @required FocusNode focusNode,
    this.response = 'Enter valid username',
  })  : _focusNode = focusNode,
        super(key: key);

  final FocusNode _focusNode;
  final String response;

  @override
  Widget build(BuildContext context) {
    FirestoreContactRepository _firestoreContactRepository =
        FirestoreContactRepository();

    return AnimatedContainer(
      margin: EdgeInsets.only(bottom: 20),
      duration: Duration(milliseconds: 400),
      // color: Colors.green,
      width: double.infinity,
      height: _focusNode.hasFocus ? 220 : 0,
      child: CustomPaint(
        painter: SearchUiPainter(
          context,
          _focusNode,
        ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            children: [
              context.watch<SearchUserFormBloc>().username.value.length > 5
                  ? FutureBuilder(
                      initialData: Text('Nigger initial'),
                      future: _firestoreContactRepository.findIdByUsername(
                          context.watch<SearchUserFormBloc>().username.value,
                          context.watch<AuthenticationBloc>().state.user.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Text('No such user');
                        else if (snapshot.hasData) {
                          Contact result;
                          try {
                            result = snapshot?.data;
                          } catch (e) {
                            print(e);
                          }

                          TextStyle style = GoogleFonts.jura(
                              backgroundColor:
                                  Theme.of(context).backgroundColor);
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Username: ',
                                      style: style,
                                    ),
                                    Spacer(),
                                    Text(result?.username ?? '', style: style),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Status: ',
                                      style: style,
                                    ),
                                    Spacer(),
                                    Text(result?.status ?? '', style: style),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      'Id: ',
                                      style: style,
                                    ),
                                    Spacer(),
                                    Text(result?.id ?? '', style: style),
                                  ],
                                ),
                                SizedBox(height: 5),
                                FoundUserUi(result: result)
                              ],
                            ),
                          );
                        }
                      },
                    )
                  : Container(
                      height: 220,
                      alignment: Alignment.center,
                      child: Text('Enter username at least 6 charachters long'))
            ],
          ),
        ),
      ),
    );
  }
}

class FoundUserUi extends StatelessWidget {
  const FoundUserUi({
    Key key,
    @required this.result,
  }) : super(key: key);

  final Contact result;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              Spacer(),
              Center(
                child: Image.asset(
                  'assets/images/avatar-placeholder.png',
                  height: 70,
                  // colorBlendMode:
                  //     BlendMode.color,
                ),
              ),
              Spacer(),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 5,
                              color: Theme.of(context).backgroundColor)),
                    ),
                    width: double.infinity,
                    height: 40,
                    child: IconButton(
                      icon: Icon(Icons.add,
                          color: Theme.of(context).backgroundColor),
                      onPressed: () => context.read<ContactBloc>().add(
                            SendFriendshipRequest(
                              message: 'Add me mah sweet boy',
                              contactId: result?.id ?? '',
                              uid: context
                                  .read<AuthenticationBloc>()
                                  .state
                                  .user
                                  .id,
                            ),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.all(5),
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(width: 5),
                    Text(
                      'Messsage',
                      style: GoogleFonts.jura(
                          color: Theme.of(context).backgroundColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                TextFormField(
                  style: GoogleFonts.jura(
                      color: Theme.of(context).backgroundColor),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    counterStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    helperText: ' ',
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                  ),
                  cursorColor: Theme.of(context).backgroundColor,
                  maxLength: 60,
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SearchUiPainter extends CustomPainter {
  final BuildContext context;
  final FocusNode focusNode;

  SearchUiPainter(this.context, this.focusNode);

  @override
  void paint(Canvas canvas, Size size) {
    double sw = size.width;
    double sh = size.height;
    Paint innerFramePaint = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    Path innerFramePath = Path()
      ..lineTo(sw, sh)
      ..moveTo(sw, 0)
      ..lineTo(0, sh);

    canvas.drawPath(innerFramePath, innerFramePaint);

    Paint outerFramePaint = Paint()
      ..color = Theme.of(context).primaryColor.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    Path outerFramePath = Path()
      ..lineTo(sw * 0.1, 0)
      ..moveTo(sw * 0.9, 0)
      ..lineTo(sw, 0)
      ..lineTo(sw, sh * 0.1)
      ..moveTo(sw, sh * 0.9)
      ..lineTo(sw, sh)
      ..lineTo(sw * 0.9, sh)
      ..moveTo(sw * 0.1, sh)
      ..lineTo(0, sh)
      ..lineTo(0, sh * 0.9)
      ..moveTo(0, sh * 0.1)
      ..lineTo(0, 0);

    if (focusNode.hasFocus) canvas.drawPath(outerFramePath, outerFramePaint);
  }

  @override
  bool shouldRepaint(SearchUiPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(SearchUiPainter oldDelegate) => false;
}
