import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/screens/cart/empty_screen.dart';
import 'package:lazyclub/screens/wishlist/wishlist_widget.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/back_Btn.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatefulWidget {
  static const routeName = "/WishlistScreenState";
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final favorProvider = Provider.of<FavorProvider>(context);
    final favorItemList =
        favorProvider.getFavorItems.values.toList().reversed.toList();
    return favorItemList.isEmpty
        ? EmptyScreen(
            imgUrl: 'assets/result_none.png',
            title: '즐겨찾기가 없어요',
            subtitle: '즐겨찾기를 추가해보세요',
            buttontext: '보러가기')
        : Scaffold(
            appBar: AppBar(
                leading: BackBtn(),
                title: TextWidget(
                  text: '위시리스트',
                  textSize: 22,
                  isTitle: true,
                  color: color,
                ),
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        GlobalMethods.warningDialog(
                            title: 'empty your wishlist?',
                            content: 'are you sure?',
                            fct: () {},
                            context: context);
                      },
                      icon: Icon(
                        IconlyBroken.delete,
                        color: color,
                      ))
                ]),
            body: MasonryGridView.count(
              itemCount: favorItemList.length,
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: favorItemList[index], child: WishListWidget());
              },
            ));
  }
}
