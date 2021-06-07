import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    Key? key,
    required this.chat,
    required this.isActive,
  }) : super(key: key);

  final Chatroom chat;
  final bool isActive;

  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late Future<String> avatarUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    avatarUrl = getAvatar();
  }

  Future<String> getAvatar() async {
    String result;
    final bool hasPic =
        await RepositoryProvider.of<FirestoreHelperRepository>(context)
            .userHasAvatar(widget.chat.id);
    if (hasPic) {
      result = await RepositoryProvider.of<FirebaseStorageRepository>(context)
          .getAvatarUrlByPath(widget.chat.id);
    } else {
      result = await RepositoryProvider.of<FirebaseStorageRepository>(context)
          .getAvatarPlaceholderUrl();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: Stack(
        children: [
          FutureBuilder<String>(
              future: avatarUrl,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return Material(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!,
                      placeholder: (context, url) => Container(
                        width: 200.0,
                        height: 200.0,
                        padding: const EdgeInsets.all(70.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Theme.of(context).primaryColor),
                        ),
                      ),
                      errorWidget: (context, url, error) => Material(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        child: Image.asset(
                          'images/avatar-placeholder.png',
                          width: 200.0,
                          height: 200.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return const SizedBox();
              }),
          if (widget.isActive)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 3),
                ),
              ),
            )
        ],
      ),
    );
  }
}
