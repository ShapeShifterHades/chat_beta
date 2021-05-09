const bool kReleaseMode = false;
void safePrint(String? value) {
  if (kReleaseMode) return;
  // ignore: avoid_print
  print(value);
}

// import 'package:void_chat_beta/data/utils/safe_print.dart';
