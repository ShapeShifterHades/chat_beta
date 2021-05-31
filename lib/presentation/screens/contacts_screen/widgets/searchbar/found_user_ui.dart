import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import 'package:void_chat_beta/logic/bloc/find_user/finduser_bloc.dart';

class FoundUserUi extends StatelessWidget {
  FoundUserUi({
    Key? key,
    required this.result,
    this.focusNode,
    required this.finduserController,
    this.isVisible,
  }) : super(key: key);

  final Contact? result;
  final bool? isVisible;
  final FocusNode? focusNode;
  final TextEditingController finduserController;

  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              S.of(context).contacts_user,
              style: TextStyles.body2,
            ),
            const Spacer(),
            Text(
              result?.username ?? '',
              style: TextStyles.body2,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              S.of(context).contacts_status,
              style: TextStyles.body2,
            ),
            const Spacer(),
            Text(
              result?.status ?? '',
              style: TextStyles.body2,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(
              S.of(context).contacts_id,
              style: TextStyles.body2,
            ),
            const Spacer(),
            Text(
              result?.id ?? '',
              style: TextStyles.body2,
            ),
          ],
        ),
        const SizedBox(height: 5),
        if (result!.status == 'Not in contacts')
          _BefriendForm(
              messageController: messageController,
              result: result,
              usernameTextController: finduserController),
      ],
    );
  }
}

class _BefriendForm extends StatelessWidget {
  const _BefriendForm({
    Key? key,
    required this.usernameTextController,
    required this.messageController,
    required this.result,
  }) : super(key: key);

  final TextEditingController messageController;
  final Contact? result;
  final TextEditingController usernameTextController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 120,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  'assets/images/avatar-placeholder.png',
                  height: 70,
                  // colorBlendMode:
                  //     BlendMode.color,
                ),
              ),
              const Spacer(),
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
                      onPressed: () {
                        context.read<ContactBloc>().add(
                              SendFriendshipRequest(
                                message: messageController.value.text,
                                contactId: result?.id ?? '',
                              ),
                            );
                        context.read<FinduserBloc>().add(ResetEvent());
                        usernameTextController.clear();
                        Focus.of(context).unfocus();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(5),
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
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
                    const SizedBox(width: 5),
                    Text(
                      S.of(context).contacts_form_message,
                      style: TextStyles.body2,
                    ),
                  ],
                ),
                TextFormField(
                  style: TextStyles.body2,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    counterStyle: TextStyle(color: Colors.black),
                    hintStyle: TextStyle(color: Colors.black),
                    helperText: ' ',
                    contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                  ),
                  controller: messageController,
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
