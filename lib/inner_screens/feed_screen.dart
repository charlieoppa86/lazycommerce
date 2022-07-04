import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/models/products_model.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/back_Btn.dart';
import 'package:lazyclub/widget/const.dart';
import 'package:lazyclub/widget/feed_item.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreenState";
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    return Scaffold(
      appBar: AppBar(
          title: TextWidget(
            text: '전체 상품',
            textSize: 20,
            color: color,
            isTitle: true,
          ),
          leading: BackBtn()),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: kBottomNavigationBarHeight,
            child: TextField(
              focusNode: _searchTextFocusNode,
              controller: _searchTextController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                suffix: IconButton(
                    icon: Icon(
                      IconlyLight.delete,
                      color: _searchTextFocusNode.hasFocus
                          ? Colors.red
                          : Colors.black,
                    ),
                    onPressed: (() {
                      _searchTextController!.clear();
                      _searchTextFocusNode.unfocus();
                    })),
                hintText: '원하는 상품을 검색해보세요',
                prefixIcon: Icon(IconlyLight.search),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.green, width: 1)),
              ),
            ),
          ),
          GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: size.width / (size.height * 0.55),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              children: List.generate(allProducts.length, (index) {
                return ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: FeedWidget(),
                );
              }))
        ]),
      ),
    );
  }
}
