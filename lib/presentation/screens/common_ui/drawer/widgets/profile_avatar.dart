import 'dart:io';

import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/main_bloc/bloc/main_bloc.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/drawer/widgets/arctext.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileAvatarState createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          const SizedBox(width: 15),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 136,
                height: 136,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(70),
                    border: Border.all(
                      width: 0.3,
                      color: Theme.of(context).primaryColor,
                    )),
                // child:,
              ),
              ArcText(
                radius: 52,
                text:
                    'Id:   ${context.watch<AuthenticationBloc>().state.user.id.toLowerCase()}',
                textStyle: TextStyles.body2
                    .copyWith(color: Theme.of(context).primaryColor),
                startAngle: -2.16,
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<MainAppBloc>(context)
                      .add(const UpdateAvatar());
                },
                child: Container(
                    width: 102,
                    height: 102,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Center(
                      child: BlocBuilder<MainAppBloc, MainAppState>(
                        builder: (context, state) {
                          if (state is MainAppLoaded) {
                            return CircleAvatar(
                              backgroundImage: MemoryImage(state.avatar),
                              radius: 60,
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
