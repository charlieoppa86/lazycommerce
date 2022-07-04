import 'package:flutter/material.dart';
import 'package:lazyclub/widget/text_widget.dart';

class AuthButton extends StatelessWidget {
  const AuthButton(
      {super.key,
      required this.fct,
      required this.buttontext,
      this.primary = Colors.white54});

  final Function fct;
  final String buttontext;
  final Color primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: primary),
          onPressed: () {
            fct();
          },
          child: TextWidget(
            color: Colors.white,
            textSize: 18,
            text: buttontext,
          )),
    );
  }
}
