import 'package:firestore_repository/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:void_chat_beta/logic/bloc/authentication/authentication_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact/contact_bloc.dart';
import 'package:void_chat_beta/logic/bloc/contact_tabs/contact_tabs_bloc.dart';
import 'package:void_chat_beta/logic/bloc/find_user/finduser_bloc.dart';
import 'package:void_chat_beta/logic/bloc/search_button/search_button_bloc.dart';
import 'package:void_chat_beta/presentation/screens/common_ui/ui.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/contact_page_tabs.dart';
import 'package:void_chat_beta/presentation/screens/contacts_screen/widgets/contact_page_tabs_content.dart';

class ContactsView extends StatelessWidget {
  const ContactsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ContactTabsBloc>(
            create: (context) => ContactTabsBloc(context.read<ContactBloc>())),
        BlocProvider<FinduserBloc>(
            create: (context) => FinduserBloc(
                context.read<AuthenticationBloc>(),
                context.read<FirestoreContactRepository?>())),
        BlocProvider<SearchButtonBloc>(
            create: (context) =>
                SearchButtonBloc(BlocProvider.of<FinduserBloc>(context))),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: UI(
          body: GestureDetector(
            onTap: () {
              final FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Column(
              children: const [
                ContactPageTabs(),
                ContactPageTabsContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
