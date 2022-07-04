import 'package:flutter/material.dart';
import 'package:lazyclub/screens/orders/orders_widget.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/back_Btn.dart';
import 'package:lazyclub/widget/text_widget.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = "/OrderScreenState";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;

    return Scaffold(
      appBar: AppBar(
          title: TextWidget(
            text: '주문 상품',
            textSize: 20,
            color: color,
            isTitle: true,
          ),
          leading: BackBtn()),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return OrderWidget();
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: color,
            );
          },
          itemCount: 10),
    );
  }
}
