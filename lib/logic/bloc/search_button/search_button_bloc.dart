import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:void_chat_beta/logic/bloc/find_user/finduser_bloc.dart';

part 'search_button_event.dart';
part 'search_button_state.dart';

class SearchButtonBloc extends Bloc<SearchButtonEvent, SearchButtonState> {
  SearchButtonBloc(this._finduserBloc) : super(SearchButtonState.initial()) {
    _finduserSubscription =
        _finduserBloc?.stream.listen((bloc) => add(FinduserStateChanged(bloc)));
  }

  final FinduserBloc? _finduserBloc;
  StreamSubscription<FinduserState>? _finduserSubscription;

  @override
  Future<void> close() {
    _finduserSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<SearchButtonState> mapEventToState(
    SearchButtonEvent event,
  ) async* {
    if (event is FinduserStateChanged) {
      yield _mapFinduserStateChangedToState(event);
    } else if (event is SearchButtonResetEvent) yield _mapResetEventToState();
  }

  SearchButtonState _mapFinduserStateChangedToState(
      FinduserStateChanged event) {
    SearchButtonState toReturn;
    if (event.finduserState == FinduserState.loading()) {
      toReturn = SearchButtonState.loading();
    } else if (event.finduserState == FinduserState.initial()) {
      toReturn = SearchButtonState.initial();
    } else if (event.finduserState == FinduserState.error()) {
      toReturn = SearchButtonState.hasError();
    } else
      toReturn = SearchButtonState.hasResult();

    return toReturn;
  }

  SearchButtonState _mapResetEventToState() {
    return SearchButtonState.initial();
  }
}
