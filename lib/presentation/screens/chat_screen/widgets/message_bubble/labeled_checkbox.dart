import 'package:flutter/material.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class LabeledCheckbox extends StatefulWidget {
  const LabeledCheckbox({
    Key? key,
    required this.child,
    required this.value,
    required this.onChanged,
    this.activate = false,
  }) : super(key: key);

  final bool activate;
  final Widget child;
  final bool value;
  final Function onChanged;

  @override
  _LabeledCheckboxState createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.teal;
    }
    return Colors.teal;
  }

  @override
  Widget build(BuildContext context) {
    // bool _value = widget.value;
    // if (!widget.focusController) _value = false;
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        duration: Times.medium,
        color: widget.value && widget.activate
            ? Theme.of(context).primaryColor.withOpacity(0.04)
            : Colors.transparent,
        child: Row(
          children: <Widget>[
            AnimatedOpacity(
              duration: Times.slow,
              curve: Curves.easeIn,
              opacity: widget.activate ? 1 : 0,
              child: AnimatedContainer(
                // color: Colors.black,
                padding: const EdgeInsets.only(right: 5),
                duration: Times.fast,
                curve: Curves.easeIn,
                height: 30,
                width: widget.activate ? 35 : 5,
                child: Transform.scale(
                  scale: 0.7,
                  child: Checkbox(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    fillColor: MaterialStateProperty.resolveWith(getColor),
                    side: BorderSide(
                      width: 0.4,
                      color: Theme.of(context).primaryColor,
                    ),
                    value: widget.value,
                    onChanged: (bool? newValue) {
                      widget.onChanged(newValue);
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: widget.child,
            ),
          ],
        ),
      ),
    );
  }
}
