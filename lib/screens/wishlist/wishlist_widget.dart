import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/inner_screens/product_details.dart';
import 'package:lazyclub/models/favor_model.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/heart_btn.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class WishListWidget extends StatelessWidget {
  const WishListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final favorModel = Provider.of<FavorModel>(context);
    final favorProvider = Provider.of<FavorProvider>(context);
    final getCurrProduct =
        productProvider.findProductById(favorModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    bool? _isInFavor =
        favorProvider.getFavorItems.containsKey(getCurrProduct.id);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: favorModel.productId);
      },
      child: Container(
        height: size.height * 0.2,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 1),
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 8),
              width: size.width * 0.2,
              height: size.width * 0.25,
              child: FancyShimmerImage(
                imageUrl: getCurrProduct.imgUrl,
                boxFit: BoxFit.fill,
              ),
            ),
            Column(
              children: [
                Flexible(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            IconlyLight.bag2,
                            color: color,
                          )),
                      HeartBTN(
                        productId: getCurrProduct.id,
                        isInFavor: _isInFavor,
                      )
                    ],
                  ),
                ),
                Flexible(
                    child: TextWidget(
                  text: getCurrProduct.title,
                  textSize: 18,
                  isTitle: true,
                  color: color,
                  maxLines: 2,
                )),
                SizedBox(
                  height: 10,
                ),
                TextWidget(
                  text: '\$${usedPrice.toString()}',
                  textSize: 20,
                  isTitle: false,
                  color: color,
                  maxLines: 1,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
