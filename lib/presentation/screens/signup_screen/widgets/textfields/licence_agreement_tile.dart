import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';
import 'package:void_chat_beta/generated/l10n.dart';
import 'package:void_chat_beta/presentation/screens/licence_screen/licence_screen.dart';

class LicenceAgreementTile extends StatefulWidget {
  const LicenceAgreementTile({
    Key? key,
  }) : super(key: key);

  @override
  _LicenceAgreementTileState createState() => _LicenceAgreementTileState();
}

class _LicenceAgreementTileState extends State<LicenceAgreementTile> {
  late bool isChecked;
  @override
  void initState() {
    isChecked = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15),
      child: CheckboxListTile(
        selectedTileColor: Theme.of(context).primaryColor,
        value: isChecked,
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        onChanged: (bool? newValue) {
          setState(() {
            isChecked = !isChecked;
          });
        },
        title: GestureDetector(
          onTap: () => _showOverlay(context),
          child: RichText(
            text: TextSpan(
              style: TextStyles.body2
                  .copyWith(color: Theme.of(context).primaryColor),
              children: <TextSpan>[
                TextSpan(text: '${S.of(context).signup_i_agree} '),
                TextSpan(
                    style: TextStyles.body2.copyWith(color: Colors.blue),
                    text: S.of(context).signup_with_terms),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(LicenceScreen());
  }
}
