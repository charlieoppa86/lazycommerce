import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/inner_screens/feed_screen.dart';
import 'package:lazyclub/inner_screens/on_sale_screen.dart';
import 'package:lazyclub/models/products_model.dart';
import 'package:lazyclub/provider/dark_theme_provider.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/services/utils.dart';
import 'package:lazyclub/widget/const.dart';
import 'package:lazyclub/widget/feed_item.dart';
import 'package:lazyclub/widget/on_sale_widget.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils(context);
    final Color color = Utils(context).color;
    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnsale = productProviders.getOnSaleProducts;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Image.asset(
          'assets/logo.png',
          height: 35,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.25,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Consts.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: Consts.offerImages.length,
                pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                      color: Colors.white,
                      activeColor: Colors.black,
                    )),
                autoplay: true,
                control: SwiperControl(color: Colors.black),
              ),
            ),
            TextButton(
                onPressed: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: OnSaleScreen.routeName);
                },
                child: TextWidget(
                  text: '더 보기',
                  color: Colors.cyan,
                  isTitle: true,
                  textSize: 16,
                )),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      TextWidget(
                        text: '세일 중',
                        color: Colors.red,
                        textSize: 22,
                        isTitle: true,
                      ),
                      Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                Flexible(
                  child: SizedBox(
                    height: size.height * 0.25,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: productsOnsale.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: productsOnsale[index],
                              child: OnSaleWidget());
                        }),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: '전체 상품',
                    color: Colors.black,
                    textSize: 20,
                    isTitle: true,
                  ),
                  TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            context: context, routeName: FeedsScreen.routeName);
                      },
                      child: TextWidget(
                        text: '더 보기',
                        color: Colors.cyan,
                        isTitle: true,
                        textSize: 14,
                      )),
                ],
              ),
            ),
            GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: size.width / (size.height * 0.55),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                children: List.generate(
                    allProducts.length < 4 ? allProducts.length : 4, (index) {
                  return ChangeNotifierProvider.value(
                    value: allProducts[index],
                    child: FeedWidget(),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
