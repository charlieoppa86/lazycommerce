import 'package:flutter/material.dart';
import 'package:lazyclub/inner_screens/cat_screen.dart';
import 'package:lazyclub/provider/dark_theme_provider.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.imgPath,
      required this.passedcolor})
      : super(key: key);

  final String catText, imgPath;
  final Color passedcolor;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EachCategoryScreen.routeName,
            arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.6))),
        child: Column(children: [
          Container(
            width: _screenWidth * 0.3,
            height: _screenWidth * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(imgPath), fit: BoxFit.fill)),
          ),
          TextWidget(
            text: catText,
            color: color,
            textSize: 16,
            isTitle: true,
          )
        ]),
      ),
    );
  }
}
