import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  final String uid;
  late final String username;
  late final File avatar;
  final FirestoreHelperRepository firestoreHelperRepository;
  final FirebaseStorageRepository firebaseStorageRepository;
  MainAppBloc(
      {required AuthenticationBloc authenticationBloc,
      required this.firebaseStorageRepository,
      required this.firestoreHelperRepository})
      : uid = authenticationBloc.state.user.id,
        super(MainAppLoading());

  @override
  Stream<MainAppState> mapEventToState(
    MainAppEvent event,
  ) async* {
    if (event is LoadMainApp) {
      yield* _mapMainAppLoadingToState(event);
    }
    if (event is SwitchView) {
      yield* _mapSwitchViewToState(event);
    } else if (event is DialogRequested) {
      yield* _mapDialogRequestedToState(event);
    }
  }

  Future<String> getUsername() async {
    final String _result =
        await firestoreHelperRepository.getUsernameById(uid) ?? '';
    return _result;
  }

  Future<File> getAvatar() async {
    File? _result = await firebaseStorageRepository.getAvatarById(uid);
    _result ??= await firebaseStorageRepository.getAvatarPlaceholder();
    return _result!;
  }

  Stream<MainAppState> _mapMainAppLoadingToState(LoadMainApp event) async* {
    username = await getUsername();
    avatar = await getAvatar();
    yield MainAppLoaded(uid: uid, username: username, avatar: avatar);
  }

  Stream<MainAppState> _mapSwitchViewToState(SwitchView event) async* {
    yield MainAppLoaded(
        currentView: event.view, uid: uid, username: username, avatar: avatar);
  }

  Stream<MainAppState> _mapDialogRequestedToState(
      DialogRequested event) async* {
    yield MainAppDialog(
        chat: event.chat, uid: uid, username: username, avatar: avatar);
  }
}
