import 'package:flutter/material.dart';
import 'package:lazyclub/widget/text_widget.dart';

class GlobalMethods {
  static navigateTo(
      {required BuildContext context, required String routeName}) {
    Navigator.pushNamed(context, routeName);
  }

  static Future<void> warningDialog({
    required String title,
    required String content,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  text: '취소',
                  color: Colors.blue,
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  text: '확인',
                  color: Colors.red,
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String content,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('에러가 발생했어요\n 잠시 후에 다시 시도해 주세요'),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  text: '확인',
                  color: Colors.blue,
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
}
