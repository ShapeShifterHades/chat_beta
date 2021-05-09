import 'dart:core';

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
const String chatRoute = '/chatroom';

// String generateChatroomFireStoreName(String id1, String id2) {
//   final List _list = [id1, id2];
//   _list.sort((a, b) => a.compareTo(b) ) ;
//   final String result = _list.join('@');
//   safePrint(result);
//   return result;
// }

// String? getInterlocutorIdFromChatname(String? chatname, String authId) {
//   var result = chatname!.replaceAll(authId, '').replaceAll('@', '');

//   return result;
// }

// String? getInterlocutorUsernameFromChat(Chatroom chatroom, String authId) {
//   return chatroom.name!.startsWith(authId)
//       ? chatroom.username2
//       : chatroom.username1;
// }
