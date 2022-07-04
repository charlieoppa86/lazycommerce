import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/screens/cart/cart_widget.dart';
import 'package:lazyclub/screens/cart/empty_screen.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Widget _checkOut({required BuildContext context}) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList =
        cartProvider.getCartItems.values.toList().reversed.toList();
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(children: [
          Material(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                GlobalMethods.warningDialog(
                    title: 'empty your cart?',
                    content: 'are you sure?',
                    fct: () {
                      cartProvider.clearCart();
                    },
                    context: context);
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextWidget(
                  text: '주문하기',
                  textSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Spacer(),
          TextWidget(
            text: '총 금액 : \$1.56',
            color: color,
            textSize: 18,
            isTitle: true,
          )
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemList = cartProvider.getCartItems.values.toList();
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    return Scaffold(
        appBar: AppBar(
            title: TextWidget(
              text: '장바구니 (${cartItemList.length})',
              textSize: 22,
              isTitle: true,
              color: color,
            ),
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {
                    cartProvider.clearCart();
                  },
                  icon: Icon(
                    IconlyBroken.delete,
                    color: color,
                  ))
            ]),
        body: Column(
          children: [
            _checkOut(context: context),
            Expanded(
              child: ListView.builder(
                  itemCount: cartItemList.length,
                  itemBuilder: ((context, index) {
                    return ChangeNotifierProvider.value(
                        value: cartItemList[index],
                        child: CartWidget(
                          q: cartItemList[index].quantity,
                        ));
                  })),
            ),
          ],
        ));
  }
}
