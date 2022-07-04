import 'package:flutter/material.dart';
import 'package:lazyclub/inner_screens/feed_screen.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/text_widget.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    super.key,
    required this.imgUrl,
    required this.title,
    required this.subtitle,
    required this.buttontext,
  });

  final String imgUrl, title, subtitle, buttontext;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(imgUrl,
                    width: double.infinity, height: size.height * 0.4),
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: title,
                  color: color,
                  textSize: 32,
                  isTitle: true,
                ),
                SizedBox(
                  height: 10,
                ),
                TextWidget(text: subtitle, color: color, textSize: 16),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        primary: Colors.green),
                    onPressed: () {},
                    child: Text(buttontext))
              ]),
        ),
      ),
    );
  }
}
