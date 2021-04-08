// import 'package:firestore_repository/firestore_repository.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:void_chat_beta/contacts/bloc/contact_bloc.dart';
// import 'package:void_chat_beta/contacts/widgets/searchbar/search_bloc.dart';

// class FoundUserUi extends StatelessWidget {
//   const FoundUserUi({
//     Key key,
//     @required this.result,
//   }) : super(key: key);

//   final Contact result;

//   @override
//   Widget build(BuildContext context) {
//     TextStyle style =
//         GoogleFonts.jura(backgroundColor: Theme.of(context).backgroundColor);
//     return Padding(
//       padding: const EdgeInsets.only(left: 0, right: 0, bottom: 8),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               Text(
//                 'Username: ',
//                 style: style,
//               ),
//               Spacer(),
//               Text(result?.username ?? '', style: style),
//             ],
//           ),
//           SizedBox(height: 5),
//           Row(
//             children: [
//               Text(
//                 'Status: ',
//                 style: style,
//               ),
//               Spacer(),
//               Text(result?.status ?? '', style: style),
//             ],
//           ),
//           SizedBox(height: 5),
//           Row(
//             children: [
//               Text(
//                 'Id: ',
//                 style: style,
//               ),
//               Spacer(),
//               Text(result?.id ?? '', style: style),
//             ],
//           ),
//           SizedBox(height: 5),
//           Row(
//             children: [
//               Container(
//                 width: 80,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor.withOpacity(0.8),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(10),
//                     bottomLeft: Radius.circular(10),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Spacer(),
//                     Center(
//                       child: Image.asset(
//                         'assets/images/avatar-placeholder.png',
//                         height: 70,
//                         // colorBlendMode:
//                         //     BlendMode.color,
//                       ),
//                     ),
//                     Spacer(),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         child: Container(
//                           decoration: BoxDecoration(
//                             border: Border(
//                                 top: BorderSide(
//                                     width: 5,
//                                     color: Theme.of(context).backgroundColor)),
//                           ),
//                           width: double.infinity,
//                           height: 40,
//                           child: IconButton(
//                             icon: Icon(Icons.add,
//                                 color: Theme.of(context).backgroundColor),
//                             onPressed: () {
//                               context.read<ContactBloc>().add(
//                                     SendFriendshipRequest(
//                                       message: context
//                                           .read<SearchUserFormBloc>()
//                                           .username
//                                           .value,
//                                       contactId: result?.id ?? '',
//                                     ),
//                                   );
//                               context.read<SearchUserFormBloc>().emitSuccess();
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   margin: EdgeInsets.all(5),
//                   height: 120,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).primaryColor.withOpacity(0.8),
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       bottomRight: Radius.circular(10),
//                     ),
//                   ),
//                   width: double.infinity,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           SizedBox(width: 5),
//                           Text(
//                             'Messsage',
//                             style: GoogleFonts.jura(
//                                 color: Theme.of(context).backgroundColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       TextFormField(
//                         style: GoogleFonts.jura(
//                             color: Theme.of(context).backgroundColor),
//                         decoration: InputDecoration(
//                           border: InputBorder.none,
//                           counterStyle: TextStyle(color: Colors.black),
//                           hintStyle: TextStyle(color: Colors.black),
//                           helperText: ' ',
//                           contentPadding: EdgeInsets.fromLTRB(5, 5, 5, 10),
//                         ),
//                         cursorColor: Theme.of(context).backgroundColor,
//                         maxLength: 60,
//                         maxLines: 3,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }