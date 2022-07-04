import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/inner_screens/product_details.dart';
import 'package:lazyclub/models/products_model.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/heart_btn.dart';
import 'package:lazyclub/widget/price_widget.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final favorProvider = Provider.of<FavorProvider>(context);
    bool? _isInFavor = cartProvider.getCartItems.containsKey(productModel.id);
    return Material(
      color: Theme.of(context).cardColor.withOpacity(0.9),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: productModel.id);
/*           GlobalMethods.navigateTo(
              context: context, routeName: ProductDetails.routeName); */
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FancyShimmerImage(
                  imageUrl: productModel.imgUrl,
                  height: size.width * 0.2,
                  width: size.width * 0.25,
                  boxFit: BoxFit.fill,
                ),
                Column(
                  children: [
                    TextWidget(
                      text: productModel.isPiece ? '1 Piece' : '1 KG',
                      color: color,
                      textSize: 22,
                      isTitle: true,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _isInCart
                              ? null
                              : () {
                                  final User? user = authInstance.currentUser;
                                  if (user == null) {
                                    GlobalMethods.errorDialog(
                                        content: '로그인이 필요합니다',
                                        context: context);
                                    return;
                                  }
                                  cartProvider.addProductsToCart(
                                      productId: productModel.id, quantity: 1);
                                },
                          child: Icon(
                            _isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                            size: 22,
                            color: _isInCart ? Colors.green : color,
                          ),
                        ),
                        HeartBTN(
                          productId: productModel.id,
                          isInFavor: _isInFavor,
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            PriceWidget(
              salePrice: productModel.salePrice,
              isOnsale: true,
              price: productModel.price,
              textPrice: '1',
            ),
            SizedBox(
              height: 8,
            ),
            TextWidget(
              text: productModel.title,
              color: color,
              textSize: 14,
              isTitle: true,
            )
          ]),
        ),
      ),
    );
  }
}
