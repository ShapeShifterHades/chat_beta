import 'package:flutter/material.dart';

import 'package:void_chat_beta/ui/drawer/portrait_mobile_drawer/portrait_drawer_wrapper.dart';

class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PortraitMobileUI(
      routeName: 'Contacts',
      child: Container(
        color: Colors.amber.withOpacity(0.4),
        child: Text(
          'ContactList content',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:void_chat_beta/ui/widgets/build_app_bar.dart';
// import 'package:void_chat_beta/ui/widgets/contacts/add_user_button.dart';
// import 'package:void_chat_beta/ui/widgets/contacts/contact_list.dart';

// class FindUserScreen extends StatefulWidget {
//   @override
//   _FindUserScreenState createState() => _FindUserScreenState();
// }

// class _FindUserScreenState extends State<FindUserScreen> {
//   TextEditingController searchTextEditingController = TextEditingController();
//   String contactUsernameToAdd;
//   String myUserId;
//   String myUsername;
//   QuerySnapshot searchSnapshot;

//   Future<void> getMyUserId() async {
//     try {
//       myUserId = FirebaseAuth.instance.currentUser.uid;
//       // print('WORKES ' + myUserId);
//     } catch (e) {
//       print('An error occured while getting your userId: ' + e.toString());
//     }
//   }

//   Future<void> getMyUsername() async {
//     try {
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(myUserId)
//           .get()
//           .then((value) {
//         // print('WORKES ' + value.get('bio.nickname'));
//         return myUsername = value.get('bio.nickname');
//       });
//     } catch (e) {
//       print('An error occured while getting your username: ' + e.toString());
//     }
//   }

//   initiateSearch() async {
//     await FirebaseFirestore.instance
//         .collection('users')
//         .where('bio.nickname',
//             isEqualTo: searchTextEditingController.text.toLowerCase())
//         .get()
//         .then((val) {
//       print(val.docs[0].get('bio.nickname'));
//       contactUsernameToAdd = val.docs[0].get('bio.nickname');
//       searchTextEditingController.clear();
//       setState(() {
//         searchSnapshot = val;
//       });
//     }).catchError((e) {
//       setState(() {
//         searchSnapshot = null;
//         searchTextEditingController.clear();
//         print('User not found');
//       });
//     });
//     FocusScope.of(context).unfocus();
//   }

//   @override
//   void initState() {
//     super.initState();
//     getMyUserId();
//     getMyUsername();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(context, title: 'Find user'),
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[600],
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: searchTextEditingController,
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Search username...',
//                         hintStyle: TextStyle(
//                           color: Colors.white.withOpacity(0.6),
//                         ),
//                       ),
//                     ),
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       initiateSearch();
//                     },
//                     child: Container(
//                       margin: EdgeInsets.all(4),
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.all(Radius.circular(20)),
//                         color: Colors.blueGrey[300],
//                       ),
//                       child: Icon(
//                         Icons.search,
//                         color: Colors.white,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             searchSnapshot != null
//                 ? Container(
//                     child: Column(
//                       children: [
//                         Text(
//                             'user found: ${searchSnapshot.docs[0].get('bio.nickname')}'),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             MaterialButton(
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 14, horizontal: 14),
//                               child: Text('Message'),
//                               color: Colors.green,
//                               disabledColor: Colors.blueGrey,
//                               disabledTextColor: Colors.white60,
//                               onPressed: null,
//                             ),
//                             AddUserButton(
//                               myId: myUserId,
//                               myUsername: myUsername,
//                               username: contactUsernameToAdd,
//                               userId: searchSnapshot.docs[0].id,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 : Container(),
//             ContactList(
//               myId: myUserId,
//               myUsername: myUsername,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
