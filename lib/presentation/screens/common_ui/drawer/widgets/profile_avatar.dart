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
  File? _image;
  final picker = ImagePicker();

  Future getImage() async {
    final PickedFile? pickedFile =
        await picker.getImage(source: ImageSource.gallery);
    final String _id =
        BlocProvider.of<AuthenticationBloc>(context).state.user.id;
    final String _uploadPath = '$_id/profile/avatar.png';
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        RepositoryProvider.of<FirestoreHelperRepository>(context)
            .setUpAvatar(UserProfile(uid: _id, avatar: _uploadPath));
        RepositoryProvider.of<FirebaseStorageRepository>(context)
            .uploadAvatar(_id, _image!);
      } else {
        print('No image selected.');
      }
    });
  }

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
                  getImage();
                  setState(() {});
                },
                child: Container(
                  width: 102,
                  height: 102,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Center(
                    child: FutureBuilder(
                        future:
                            RepositoryProvider.of<FirebaseStorageRepository>(
                                    context)
                                // .getAvatarPlaceholderUrl(),
                                .getAvatarUrlById(context
                                    .watch<AuthenticationBloc>()
                                    .state
                                    .user
                                    .id),
                        builder: (ctx, snap) {
                          if (snap.hasData) {
                            return CircleAvatar(
                              backgroundImage:
                                  Image.network(snap.data.toString()).image,
                              radius: 60,
                            );
                            // return CircleAvatar(
                            //   backgroundImage:
                            //       Image.file((BlocProvider.of<MainAppBloc>(context).state as MainAppLoaded).avatar).image,
                            //   radius: 60,
                            // );
                          }
                          return Container();
                        }),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
