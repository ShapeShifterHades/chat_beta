import 'package:firestore_repository/firestore_repository.dart';

/// Next defined all routing constants used within the app

const String initialRoute = '/';
const String homeRoute = '/messages';
const String loginRoute = '/login';
const String signupRoute = '/signup';
const String contactsRoute = '/contacts';
const String settingsRoute = '/settings';
const String securityRoute = '/security';
const String faqRoute = '/faq';
const String splashRoute = '/splash';

String generateChatroomFireStoreName(String id1, String id2) {
  List _list = [id1, id2];
  _list.sort((a, b) => a.compareTo(b));
  var result = _list.join('@');
  print(result);
  return result;
}

String? getInterlocutorIdFromChatname(String? chatname, String authId) {
  var result = chatname!.replaceAll(authId, '').replaceAll('@', '');

  return result;
}

String? getInterlocutorUsernameFromChat(Chatroom chatroom, String authId) {
  return chatroom.name!.startsWith(authId)
      ? chatroom.username2
      : chatroom.username1;
}
