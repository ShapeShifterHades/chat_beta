import 'package:flutter/material.dart';
import 'package:void_chat_beta/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';

class LicenceAgreementTile extends StatelessWidget {
  const LicenceAgreementTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: CheckboxListTile(
        value: false,
        onChanged: (bool? newValue) {},
        title: RichText(
          text: TextSpan(
            style: TextStyles.body1,
            children: <TextSpan>[
              TextSpan(text: S.of(context).signup_i_agree + ' '),
              TextSpan(
                  style: TextStyles.body1.copyWith(color: Colors.blue),
                  text: S.of(context).signup_with_terms),
            ],
          ),
        ),
      ),
    );
  }
}
