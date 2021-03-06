import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contacts/contacts_bloc.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/tiles/contact_tile.dart';

class ContactItem extends StatefulWidget {
  const ContactItem({
    Key? key,
    required this.sorted,
    required this.index,
  }) : super(key: key);

  final List<Contact> sorted;
  final int index;

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  // CustomAnimationControl  fingerprintAnimationcontroller
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          ContactTile(
            id: 'ID: ${widget.sorted[widget.index].id!.toUpperCase()}',
            child: SizedBox(
              width: 300,
              height: 70,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    // width: 70,
                    height: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                    ),

                    child: Center(
                      child: Image.asset(
                        'assets/images/avatar-placeholder.png',
                        colorBlendMode: BlendMode.color,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Text(widget.sorted[widget.index].username!,
                        style: TextStyles.body1.copyWith(fontSize: 20)),
                  ),
                  const Spacer(),
                  Container(
                    width: 60,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Icon(
                      Icons.fingerprint,
                      size: 34,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // ),28
          ),
          const SizedBox(height: 1.5),
          Row(
            children: [
              const Spacer(),
              ClipPath(
                clipper: DrawerMenuButtonClipper(),
                child: AnimatedContainer(
                  curve: Curves.easeInCubic,
                  key: const Key('left_button'),
                  duration: Times.fastest,
                  width: 120,
                  padding: const EdgeInsets.all(0),
                  height: isExpanded ? 50 : 0,
                  child: Center(
                      child: GestureDetector(
                    onTap: () => context.read<ContactsBloc>().add(
                          RemoveContactRequest(
                            contactId: widget.sorted[widget.index].id,
                            uid: context
                                .read<AuthenticationBloc>()
                                .state
                                .user
                                .id,
                          ),
                        ),
                    child: ClipPath(
                      clipper: DrawerMenuButtonClipper(),
                      child: Container(
                        alignment: Alignment.center,
                        width: 110,
                        height: 40,
                        // margin: EdgeInsets.all(5),
                        color: Theme.of(context).scaffoldBackgroundColor,

                        child: Text(
                          S.of(context).contacts_form_message,
                          style: TextStyles.body1.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
              const SizedBox(width: 8),
              ClipPath(
                clipper: DrawerMenuButtonClipper(),
                child: AnimatedContainer(
                  curve: Curves.easeInCubic,
                  key: const Key('right_button'),
                  duration: Times.fastest,
                  width: 120,
                  height: isExpanded ? 50 : 0,
                  child: Center(
                    child: ClipPath(
                      clipper: DrawerMenuButtonClipper(),
                      child: Container(
                        alignment: Alignment.center,
                        width: 110,
                        height: 40,
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Text(
                          S.of(context).contacts_form_remove,
                          style: TextStyles.body1.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          )
        ],
      ),
    );
  }
}

class DrawerMenuButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width - 8, size.height);
    path.lineTo(size.width, size.height - 8);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
