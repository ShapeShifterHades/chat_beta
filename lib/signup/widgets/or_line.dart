import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:void_chat_beta/signup/widgets/constants.dart';
import 'package:void_chat_beta/styles.dart';

class OrLine extends StatelessWidget {
  const OrLine({
    Key key,
    @required this.orLineHeight,
  }) : super(key: key);

  final Animation<double> orLineHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.size.width * 0.9,
      decoration: buildFormBackground5(context),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                'signup_or'.tr,
                style: TextStyles.body1,
              ),
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
      )),
    );
  }
}
