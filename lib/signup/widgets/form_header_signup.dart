import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class FormHeaderSignUp extends StatelessWidget {
  final Color color;
  final String title;

  const FormHeaderSignUp({
    Key key,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: 
      // context.watch<SignUpCubit>().state.status.isValidated 
      
           () {
              FocusScope.of(context).unfocus();
              // return context.read<SignUpCubit>().signUpFormSubmitted();
            }
        ,
      child: Container(
        height: 30,
        width: double.infinity,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 29,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: GoogleFonts.jura(
                      letterSpacing: 2,
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     GestureDetector(
            //       onTap: () =>
            //           Navigator.of(context).pushNamed<void>(loginRoute),
            //       onPanUpdate: (details) {
            //         if (details.delta.dx > 0) {
            //           Navigator.of(context).pushNamed<void>(loginRoute);
            //         }
            //       },
            //       child: Container(
            //         height: 38,
            //         width: 220,
            //         alignment: Alignment.centerRight,
            //         decoration: BoxDecoration(
            //           color: Theme.of(context).backgroundColor,
            //           borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(14),
            //           ),
            //         ),
            //         child: SwitchAuthButton(
            //           text: 'signup_switch_to_login'.tr,
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 1),
            //   ],
            // ),
            SizedBox(height: 1),
          ],
        ),
      ),
    );
  }
}
