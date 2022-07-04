import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:lazyclub/provider/dark_theme_provider.dart';
import 'package:lazyclub/screens/auth/firebase_consts.dart';
import 'package:lazyclub/screens/auth/forget_password.dart';
import 'package:lazyclub/screens/auth/login.dart';
import 'package:lazyclub/screens/orders/orders_screen.dart';
import 'package:lazyclub/screens/viewed_recently/viewed_recently.dart';
import 'package:lazyclub/screens/wishlist/wishlist_screen.dart';
import 'package:lazyclub/services/global_methods.dart';
import 'package:lazyclub/widget/text_widget.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('주소 변경'),
            content: TextField(
              onChanged: (value) {
                _addressTextController.text;
              },
              controller: _addressTextController,
              maxLines: 2,
              decoration: InputDecoration(hintText: '다른 주소를 입력하세요'),
            ),
            actions: [TextButton(onPressed: () {}, child: Text('업데이트'))],
          );
        });
  }

  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: Icon(IconlyLight.arrowRight2),
      onTap: (() {
        onPressed();
      }),
    );
  }

  final User? user = authInstance.currentUser;

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25,
            ),
            RichText(
                text: TextSpan(
                    children: <TextSpan>[
                  TextSpan(
                      text: '내 이름',
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('내 이름 누군가 누름');
                        })
                ],
                    text: '안녕, ',
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 24,
                        fontWeight: FontWeight.bold))),
            TextWidget(
                text: 'charlieoppa86@gmail.com', color: color, textSize: 14),
            SizedBox(
              height: 20,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            _listTiles(
                title: 'Address',
                subtitle: 'Address...',
                icon: IconlyLight.profile,
                onPressed: () async {
                  await _showAddressDialog();
                },
                color: color),
            _listTiles(
                title: 'Orders',
                icon: IconlyLight.bag,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: OrderScreen.routeName);
                },
                color: color),
            _listTiles(
                title: 'Wishlist',
                icon: IconlyLight.heart,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: WishlistScreen.routeName);
                },
                color: color),
            _listTiles(
                title: 'Viewed',
                icon: IconlyLight.show,
                onPressed: () {
                  GlobalMethods.navigateTo(
                      context: context, routeName: ViewedScreen.routeName);
                },
                color: color),
            _listTiles(
                title: 'Forget Password',
                icon: IconlyLight.unlock,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ForgetPasswordScreen()));
                },
                color: color),
            SwitchListTile(
                title: TextWidget(
                  text: themeState.getDarkTheme ? 'Dark Mode' : 'Light Mode',
                  color: color,
                  textSize: 20,
                ),
                secondary: Icon(themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                value: themeState.getDarkTheme,
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                }),
            _listTiles(
                title: user == null ? '로그인' : '로그아웃',
                icon: user == null ? IconlyLight.login : IconlyLight.logout,
                onPressed: () {
                  if (user == null) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                  }
                  GlobalMethods.warningDialog(
                      title: '로그아웃',
                      content: '정말 로그아웃 하시겠습니까?',
                      fct: () async {
                        await authInstance.signOut();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      context: context);
                },
                color: color),
          ],
        ),
      ),
    ));
  }
}
