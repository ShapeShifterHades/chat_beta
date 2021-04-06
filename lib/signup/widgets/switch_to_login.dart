import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:void_chat_beta/constants/constants.dart';

class SwitchToLogin extends StatelessWidget {
  const SwitchToLogin({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(loginRoute);
        },
        child: Container(
          alignment: Alignment.center,
          height: 60,
          child: Shimmer.fromColors(
            baseColor: Theme.of(context).primaryColor.withOpacity(0.5),
            highlightColor: Theme.of(context).primaryColor,
            loop: 0,
            period: Duration(milliseconds: 2500),
            child: Text(
              'signup_switch_to_login'.tr,
              style: GoogleFonts.jura(
                fontWeight: FontWeight.w300,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
