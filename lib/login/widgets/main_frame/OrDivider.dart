import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({
    Key key,
    @required this.orLineHeight,
  }) : super(key: key);

  final Animation<double> orLineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width * 0.9,
      decoration: buildOrLineBoxDecoration(context),
      height: orLineHeight.value,
      child: SingleChildScrollView(
        child: Container(
          color: Colors.transparent,
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  color: Theme.of(context).primaryColor,
                  thickness: 0.4,
                  indent: 12,
                  endIndent: 12,
                ),
              ),
              Text(
                'signup_or'.tr,
                style: GoogleFonts.jura(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              Expanded(
                  child: Divider(
                color: Theme.of(context).primaryColor,
                thickness: 0.4,
                indent: 12,
                endIndent: 12,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
