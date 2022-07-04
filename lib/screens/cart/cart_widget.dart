import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/inner_screens/product_details.dart';
import 'package:lazyclub/models/cart_model.dart';
import 'package:lazyclub/models/products_model.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/heart_btn.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key, required this.q});

  final int q;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  Widget _quantityController({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                fct();
              },
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productProvider.findProductById(cartModel.productId);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);
    final favorProvider = Provider.of<FavorProvider>(context);
    bool? _isInFavor = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.productId);
      },
      child: Row(children: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).cardColor),
                  child: Container(
                    height: size.width * 0.25,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: FancyShimmerImage(
                      imageUrl: getCurrProduct.imgUrl,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: getCurrProduct.title,
                    color: color,
                    textSize: 18,
                    isTitle: true,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: size.width * 0.3,
                    child: Row(
                      children: [
                        _quantityController(
                            fct: () {
                              if (_quantityTextController.text == '1') {
                                return;
                              } else {
                                cartProvider
                                    .reduceQuantityByOne(cartModel.productId);
                                setState(() {
                                  _quantityTextController.text =
                                      (int.parse(_quantityTextController.text) -
                                              1)
                                          .toString();
                                });
                              }
                            },
                            color: Colors.red,
                            icon: CupertinoIcons.minus),
                        Flexible(
                          flex: 1,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            controller: _quantityTextController,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ],
                            onChanged: (value) {
                              setState(() {
                                if (value.isEmpty) {
                                  _quantityTextController.text = '1';
                                } else {
                                  return;
                                }
                              });
                            },
                          ),
                        ),
                        _quantityController(
                            fct: () {
                              cartProvider
                                  .addQuantityByOne(cartModel.productId);
                              setState(() {
                                _quantityTextController.text =
                                    (int.parse(_quantityTextController.text) +
                                            1)
                                        .toString();
                              });
                            },
                            color: Colors.green,
                            icon: CupertinoIcons.plus)
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  InkWell(
                    child: Icon(
                      CupertinoIcons.cart_badge_minus,
                      color: Colors.blue,
                      size: 20,
                    ),
                    onTap: (() {
                      cartProvider.removeOneItem(cartModel.productId);
                    }),
                  ),
                  HeartBTN(
                    isInFavor: _isInFavor,
                    productId: getCurrProduct.id,
                  ),
                  TextWidget(
                    text: '\$${usedPrice.toStringAsFixed(2)}',
                    color: color,
                    textSize: 18,
                    maxLines: 1,
                  )
                ],
              ),
              SizedBox(
                width: 8,
              )
            ],
          ),
        )
      ]),
    );
  }
}
