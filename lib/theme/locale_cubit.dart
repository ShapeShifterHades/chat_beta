import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocaleCubit extends HydratedCubit<String> {
  LocaleCubit() : super('US');

  void toggleLocale() {
    emit(state == 'US' ? 'RU' : 'US');
  }

  @override
  String fromJson(Map<String, dynamic> json) {
    return json['test3'];
  }

  @override
  Map<String, String> toJson(String state) {
    return <String, String>{'test3': state};
  }
}
