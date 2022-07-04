import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/provider/dark_theme_provider.dart';
import 'package:lazyclub/screens/cart/cart_screen.dart';
import 'package:lazyclub/screens/categories.dart';
import 'package:lazyclub/screens/home_screen.dart';
import 'package:lazyclub/screens/user.dart';
import 'package:provider/provider.dart';

class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': '홈'},
    {'page': CategoryScreen(), 'title': '카테고리'},
    {'page': const CartScreen(), 'title': '카트'},
    {'page': const UserScreen(), 'title': '내 정보'},
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
          selectedItemColor: _isDark ? Colors.amberAccent : Colors.black87,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _selectedPage,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
                label: '홈'),
            BottomNavigationBarItem(
                icon: Icon(_selectedIndex == 1
                    ? IconlyBold.category
                    : IconlyLight.category),
                label: '카테고리'),
            BottomNavigationBarItem(
                icon: Consumer<CartProvider>(builder: (context, myCart, child) {
                  return Badge(
                    toAnimate: false,
                    shape: BadgeShape.circle,
                    badgeColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                    position: BadgePosition.topEnd(top: -10, end: -7),
                    badgeContent: FittedBox(
                        child: Text(myCart.getCartItems.length.toString(),
                            style: TextStyle(color: Colors.white))),
                    child: Icon(
                        _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
                  );
                }),
                label: '카트'),
            BottomNavigationBarItem(
                icon: Icon(
                    _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
                label: '내 정보'),
          ]),
    );
  }
}
