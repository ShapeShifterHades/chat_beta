import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class LocaleCubit extends HydratedCubit<Locale> {
  LocaleCubit() : super(Get.deviceLocale);

  void toggleLocale() {
    emit(state == Locale('RU') ? Locale('US') : Locale('RU'));
  }

  @override
  Locale fromJson(Map<String, dynamic> json) {
    return Locale(json['locale']);
  }

  @override
  Map<String, dynamic> toJson(Locale state) {
    return <String, String>{'locale': state.countryCode};
  }
}
