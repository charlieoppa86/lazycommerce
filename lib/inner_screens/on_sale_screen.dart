import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/models/products_model.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/back_Btn.dart';
import 'package:lazyclub/widget/on_sale_widget.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool _isEmpty = false;
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnsale = productProviders.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
          title: TextWidget(
            text: '세일 중',
            textSize: 20,
            color: color,
            isTitle: true,
          ),
          leading: BackBtn()),
      body: productsOnsale.isEmpty
          ? Center(
              child: TextWidget(
                text: '없네요!',
                color: color,
                textSize: 24,
                isTitle: true,
              ),
            )
          : GridView.count(
              childAspectRatio: size.width / (size.height * 0.45),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              children: List.generate(productsOnsale.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productsOnsale[index], child: OnSaleWidget());
              })),
    );
  }
}
