import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/inner_screens/product_details.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return ListTile(
      leading: FancyShimmerImage(
        imageUrl:
            'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
        boxFit: BoxFit.fill,
        width: size.width * 0.2,
      ),
      title: TextWidget(
        text: '타이틀 X 12',
        color: color,
        textSize: 18,
      ),
      trailing: TextWidget(
        text: '03/08/2022',
        color: color,
        textSize: 16,
      ),
      subtitle: Text('Paid : \$12.6'),
      onTap: (() {
        GlobalMethods.navigateTo(
            context: context, routeName: ProductDetails.routeName);
      }),
    );
  }
}
