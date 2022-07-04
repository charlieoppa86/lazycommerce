import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/provider/viewed_provider.dart';
import 'package:lazyclub/screens/cart/empty_screen.dart';
import 'package:lazyclub/screens/viewed_recently/viewed_widget.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/back_Btn.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class ViewedScreen extends StatefulWidget {
  static const routeName = "/ViewedScreenState";
  const ViewedScreen({super.key});

  @override
  State<ViewedScreen> createState() => _ViewedScreenState();
}

class _ViewedScreenState extends State<ViewedScreen> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final viewedProvider = Provider.of<ViewedProvider>(context);
    final viewedItemList =
        viewedProvider.getViewedItems.values.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
          leading: BackBtn(),
          title: TextWidget(
            text: '최근 본 상품',
            textSize: 22,
            isTitle: true,
            color: color,
          ),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                      title: 'empty your viewedlist?',
                      content: 'are you sure?',
                      fct: () {},
                      context: context);
                },
                icon: Icon(
                  IconlyBroken.delete,
                  color: color,
                ))
          ]),
      body: viewedItemList.isEmpty
          ? EmptyScreen(
              title: '최근 본 상품이 없어요!',
              subtitle: '살펴보신 다양한 상품을 여기에서 다시 보여드려요',
              buttontext: '보러가기',
              imgUrl: 'assets/result_none.png',
            )
          : ListView.builder(
              itemCount: viewedItemList.length,
              itemBuilder: ((context, index) {
                return ChangeNotifierProvider.value(
                    value: viewedItemList[index], child: ViewedWidget());
              })),
    );
  }
}
