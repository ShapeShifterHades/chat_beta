import 'package:bloc/bloc.dart';

class UiCubit extends Cubit<bool> {
  UiCubit() : super(false);

  void onLoginSwitcher() => emit(!state);
}
