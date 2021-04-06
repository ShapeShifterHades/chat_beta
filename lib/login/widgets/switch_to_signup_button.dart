import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class SwitchToSignUpButton extends StatelessWidget {
  const SwitchToSignUpButton({
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
          Get.toNamed('/newSignUp');
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
              'loginpage_switch_to_registration'.tr,
              style: GoogleFonts.jura(
                fontWeight: FontWeight.w500,
                fontSize: 26,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
