import 'package:flutter/material.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/text_widget.dart';

class EmptyProductWidget extends StatelessWidget {
  const EmptyProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset('assets/result_none.png',
              width: double.infinity, height: size.height * 0.4),
        ),
        SizedBox(
          height: 10,
        ),
        TextWidget(
          text: '이런!',
          color: color,
          textSize: 26,
          isTitle: true,
        ),
        SizedBox(
          height: 5,
        ),
        TextWidget(text: '아직 생성된 스터디가 없어요', color: color, textSize: 16),
        SizedBox(
          height: 30,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                primary: Colors.amber),
            onPressed: () {
              Navigator.pop(context);
            },
            child: TextWidget(
              text: '돌아가기',
              color: Colors.white,
              textSize: 16,
              isTitle: true,
            ))
      ],
    );
  }
}
