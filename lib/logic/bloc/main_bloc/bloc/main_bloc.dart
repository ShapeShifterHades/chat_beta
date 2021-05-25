import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firestore_repository/firestore_repository.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainAppBloc extends Bloc<MainAppEvent, MainAppState> {
  MainAppBloc() : super(MainAppLoading());

  @override
  Stream<MainAppState> mapEventToState(
    MainAppEvent event,
  ) async* {
    if (event is SwitchView) {
      yield* _mapSwitchViewToState(event);
    } else if (event is DialogRequested) {
      yield* _mapDialogRequestedToState(event);
    }
  }

  Stream<MainAppState> _mapSwitchViewToState(SwitchView event) async* {
    yield MainAppLoaded(currentView: event.view);
  }

  Stream<MainAppState> _mapDialogRequestedToState(
      DialogRequested event) async* {
    yield MainAppDialog(chat: event.chat);
  }
}
