import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/provider/viewed_provider.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/heart_btn.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  Widget quantityControl({
    required Function fct,
    required IconData icon,
    required Color color,
  }) {
    return Flexible(
      flex: 2,
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 18,
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final getCurrProduct = productProvider.findProductById(productId);
    final favorProvider = Provider.of<FavorProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    bool? _isInFavor =
        favorProvider.getFavorItems.containsKey(getCurrProduct.id);
    double usedPrice = getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    double totalPrice = usedPrice * int.parse(_quantityTextController.text);
    final viewedProvider = Provider.of<ViewedProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        viewedProvider.addProductToHistory(productId: productId);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.canPop(context) ? Navigator.pop(context) : null;
            },
            borderRadius: BorderRadius.circular(12),
            child: Icon(
              IconlyLight.arrowLeft2,
              size: 24,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),
        body: Column(children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: getCurrProduct.imgUrl,
              width: size.width,
              boxFit: BoxFit.scaleDown,
            ),
          ),
          Flexible(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: TextWidget(
                              text: getCurrProduct.title,
                              color: color,
                              textSize: 22,
                              isTitle: true,
                            ),
                          ),
                          HeartBTN(
                            productId: getCurrProduct.id,
                            isInFavor: _isInFavor,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: '\$${usedPrice.toStringAsFixed(2)}',
                            color: Colors.green,
                            textSize: 22,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: getCurrProduct.isPiece ? 'Piece' : '/kg',
                            color: color,
                            textSize: 12,
                            isTitle: false,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Visibility(
                            visible: getCurrProduct.isPiece ? true : false,
                            child: Text(
                              '\$${getCurrProduct.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: color,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextWidget(
                              text: '무료 배송',
                              color: Colors.white,
                              textSize: 18,
                              isTitle: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        quantityControl(
                            fct: () {
                              if (_quantityTextController.text == '1') {
                                return;
                              } else {
                                setState(() {
                                  _quantityTextController.text =
                                      (int.parse(_quantityTextController.text) -
                                              1)
                                          .toString();
                                });
                              }
                            },
                            color: Colors.red,
                            icon: CupertinoIcons.minus_square),
                        Flexible(
                            flex: 1,
                            child: TextField(
                              controller: _quantityTextController,
                              key: ValueKey('quantity'),
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.green,
                              enabled: true,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder()),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'))
                              ],
                              onChanged: (value) {
                                setState(() {
                                  if (value.isEmpty) {
                                    _quantityTextController.text = '1';
                                  } else {}
                                });
                              },
                            )),
                        quantityControl(
                            fct: () {
                              setState(() {
                                _quantityTextController.text =
                                    (int.parse(_quantityTextController.text) +
                                            1)
                                        .toString();
                              });
                            },
                            color: Colors.green,
                            icon: CupertinoIcons.plus_square),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  TextWidget(
                                    text: '합계',
                                    color: Colors.red.shade300,
                                    textSize: 20,
                                    isTitle: true,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  FittedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          text:
                                              '\$${totalPrice.toStringAsFixed(2)}/',
                                          color: color,
                                          textSize: 20,
                                          isTitle: true,
                                        ),
                                        TextWidget(
                                          text:
                                              '${_quantityTextController.text}kg',
                                          color: color,
                                          textSize: 16,
                                          isTitle: false,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                                child: Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {
                                  final User? user = authInstance.currentUser;
                                  if (user == null) {
                                    GlobalMethods.errorDialog(
                                        content: '로그인이 필요합니다',
                                        context: context);
                                    return;
                                  }
                                  cartProvider.addProductsToCart(
                                      productId: getCurrProduct.id,
                                      quantity: int.parse(
                                          _quantityTextController.text));
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextWidget(
                                    color: Colors.white,
                                    textSize: 16,
                                    text: '장바구니 담기',
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
