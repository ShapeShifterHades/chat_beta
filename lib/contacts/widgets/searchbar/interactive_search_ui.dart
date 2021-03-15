import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      height: _focusNode.hasFocus ? 80 : 0,
      child: CustomPaint(
        painter: SearchUiPainter(
          context,
          _focusNode,
        ),
        child: Column(
          children: [
            Center(
              child:
                  context.watch<SearchUserFormBloc>().username.value.length > 5
                      ? MaterialButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: context.watch<SearchUserFormBloc>().submit,
                          child: Text(
                            'FIND USER',
                            style: GoogleFonts.jura(
                                color: Theme.of(context).backgroundColor),
                          ),
                        )
                      : Text(
                          response,
                          style: GoogleFonts.jura(
                            fontWeight: FontWeight.w300,
                            backgroundColor: Theme.of(context).backgroundColor,
                            color: context
                                            .watch<SearchUserFormBloc>()
                                            .username
                                            .value
                                            .length ==
                                        0 ||
                                    context
                                        .watch<SearchUserFormBloc>()
                                        .state
                                        .isValid()
                                ? Theme.of(context).primaryColor
                                : Colors.red[800],
                          ),
                        ),
            ),
            FutureBuilder(
              initialData: Text('Nigger initial'),
              future: _firestoreContactRepository.findIdByUsername(
                  context.watch<SearchUserFormBloc>().username.value),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text('Loading');
                return Text('Result ' + snapshot.data);
              },
            )
          ],
        ),
      ),
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
      ..color = Theme.of(context).primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;
    Path innerFramePath = Path()
      ..lineTo(sw, sh)
      ..moveTo(sw, 0)
      ..lineTo(0, sh);

    canvas.drawPath(innerFramePath, innerFramePaint);

    Paint outerFramePaint = Paint()
      ..color = Theme.of(context).primaryColor
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
