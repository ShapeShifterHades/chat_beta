import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:void_chat_beta/data/utils/safe_print.dart';
import 'package:xdg_directories/xdg_directories.dart' as xdg_directories;

// ignore: avoid_classes_with_only_static_members
class PathUtil {
  static Future<String?> get dataPath async {
    String? result;
    if (Platform.isLinux) {
      result = "${xdg_directories.dataHome.path}/flutterfolio";
    } else {
      try {
        return (await getApplicationSupportDirectory()).path;
      } catch (e) {
        safePrint("$e");
      }
    }
    return result;
  }

  static Future<String> get homePath async {
    return "~/";
  }
}
