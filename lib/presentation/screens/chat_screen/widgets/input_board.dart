import 'package:flutter/material.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:void_chat_beta/core/constants/styles.dart';

class InputBoard extends StatelessWidget {
  const InputBoard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardAttachable(
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(0.64),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      height: 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor.withOpacity(0.64),
                      ),
                    ),
                    Row(
                      children: [
                        const SizedBox(width: 25),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Center(
                              child: TextFormField(
                                style: TextStyles.body1,
                                cursorColor: Theme.of(context).primaryColor,
                                showCursor: true,
                                decoration: InputDecoration(
                                  hintText: '    Enter message',
                                  focusColor: Theme.of(context).primaryColor,
                                  hintStyle: TextStyles.body1,
                                  enabledBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          alignment: const Alignment(0, 0),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.send,
                              size: 28,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.82),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
