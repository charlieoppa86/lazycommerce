import 'package:flutter/material.dart';
import 'package:lazyclub/widget/text_widget.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Image.asset(
            'assets/google_icon.png',
            width: 40,
          ),
          SizedBox(
            width: 60,
          ),
          TextWidget(text: '구글 아이디로 로그인', color: Colors.black87, textSize: 18)
        ]),
      ),
    );
  }
}
