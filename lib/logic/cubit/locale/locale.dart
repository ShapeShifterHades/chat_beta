import 'dart:ui';

import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class LocaleCubit extends HydratedCubit<String> {
  LocaleCubit() : super('en_US');

  void toggleLocale() {
    final String _newLocale = state == 'en_US' ? 'ru_RU' : 'en_US';
    S.load(Locale(_newLocale));
    emit(_newLocale);
  }

  @override
  String? fromJson(Map<String, dynamic> json) {
    return json['locale2'] as String?;
  }

  @override
  Map<String, String> toJson(String state) {
    return <String, String>{'locale2': state};
  }
}
