import 'package:flutter/material.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.salePrice,
      required this.price,
      required this.textPrice,
      required this.isOnsale});

  final double salePrice, price;
  final String textPrice;
  final bool isOnsale;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = isOnsale ? salePrice : price;
    return FittedBox(
      child: Row(children: [
        TextWidget(
            text: '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}',
            color: Colors.green,
            textSize: 22),
        SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnsale ? true : false,
          child: Text(
            '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 15),
          ),
        )
      ]),
    );
  }
}
