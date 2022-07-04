import 'package:flutter/material.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/categories_widget.dart';
import 'package:lazyclub/widget/text_widget.dart';

class CategoryScreen extends StatefulWidget {
  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Color> gridColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.blue,
  ];

  List<Map<String, dynamic>> catInfo = [
    {"imgPath": "assets/food.png", "catText": "과일"},
    {"imgPath": "assets/food.png", "catText": "채소"},
    {"imgPath": "assets/food.png", "catText": "기타"},
  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return Scaffold(
        appBar: AppBar(
          title: TextWidget(
              text: '카테고리', isTitle: true, color: Colors.black, textSize: 24),
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.count(
            childAspectRatio: 200 / 200,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            crossAxisCount: 2,
            children: List.generate(catInfo.length, (index) {
              return CategoriesWidget(
                catText: catInfo[index]['catText'],
                imgPath: catInfo[index]['imgPath'],
                passedcolor: gridColors[index],
              );
            }),
          ),
        ));
  }
}
