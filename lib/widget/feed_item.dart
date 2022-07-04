import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lazyclub/inner_screens/product_details.dart';
import 'package:lazyclub/models/products_model.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/heart_btn.dart';
import 'package:lazyclub/widget/price_widget.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({super.key});

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final favorProvider = Provider.of<FavorProvider>(context);
    bool? _isInFavor = cartProvider.getCartItems.containsKey(productModel.id);
    return Material(
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: (() {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: productModel.id);
          /*       GlobalMethods.navigateTo(
              context: context, routeName: ProductDetails.routeName); */
        }),
        child: Column(children: [
          FancyShimmerImage(
            imageUrl: productModel.imgUrl,
            height: size.width * 0.2,
            width: size.width * 0.2,
            boxFit: BoxFit.fill,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: productModel.title,
                  color: color,
                  textSize: 18,
                  isTitle: true,
                ),
                HeartBTN(
                  productId: productModel.id,
                  isInFavor: _isInFavor,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: PriceWidget(
                  isOnsale: productModel.isOnSale,
                  price: productModel.price,
                  salePrice: productModel.salePrice,
                  textPrice: _quantityTextController.text,
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Flexible(
                flex: 3,
                child: Row(
                  children: [
                    FittedBox(
                      child: TextWidget(
                        text: productModel.isPiece ? 'Piece' : 'kg',
                        color: color,
                        textSize: 16,
                        isTitle: true,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                        child: TextFormField(
                      controller: _quantityTextController,
                      key: ValueKey('10'),
                      style: TextStyle(fontSize: 18),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      enabled: true,
                      onChanged: ((value) {
                        setState(() {});
                      }),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                    )),
                  ],
                ),
              )
            ],
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: _isInCart
                  ? null
                  : () {
                      final User? user = authInstance.currentUser;
                      if (user == null) {
                        GlobalMethods.errorDialog(
                            content: '로그인이 필요합니다', context: context);
                        return;
                      }
                      cartProvider.addProductsToCart(
                          productId: productModel.id,
                          quantity: int.parse(_quantityTextController.text));
                    },
              child: TextWidget(
                text: _isInCart ? '카트에 있음' : '카트 넣기',
                color: color,
                textSize: 16,
                isTitle: true,
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))))),
            ),
          )
        ]),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
