import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/inner_screens/product_details.dart';
import 'package:lazyclub/models/favor_model.dart';
import 'package:lazyclub/models/viewed_model.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ViewedWidget extends StatefulWidget {
  const ViewedWidget({super.key});

  @override
  State<ViewedWidget> createState() => _ViewedWidgetState();
}

class _ViewedWidgetState extends State<ViewedWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final viewedModel = Provider.of<ViewedModel>(context);
    final getCurrProduct =
        productProvider.findProductById(viewedModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(
            context: context, routeName: ProductDetails.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrProduct.imgUrl,
                    boxFit: BoxFit.fill,
                    width: size.width * 0.2,
                    height: size.width * 0.25,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Column(
                    children: [
                      TextWidget(
                        text: getCurrProduct.title,
                        color: color,
                        textSize: 24,
                        isTitle: true,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextWidget(
                        text: '\$${usedPrice.toStringAsFixed(2)}',
                        color: color,
                        textSize: 20,
                      ),
                    ],
                  ),
                ],
              ),
              Material(
                child: InkWell(
                  onTap: _isInCart
                      ? null
                      : () {
                          final User? user = authInstance.currentUser;
                          if (user == null) {
                            GlobalMethods.errorDialog(
                                content: '로그인이 필요합니다', context: context);
                            return;
                          }
                          cartProvider.addProductsToCart(
                              productId: getCurrProduct.id, quantity: 1);
                        },
                  child: Icon(
                    _isInCart ? IconlyBold.bag2 : IconlyLight.bag2,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
