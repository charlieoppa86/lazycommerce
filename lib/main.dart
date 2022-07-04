import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lazyclub/firebase_options.dart';
import 'package:lazyclub/inner_screens/cat_screen.dart';
import 'package:lazyclub/inner_screens/feed_screen.dart';
import 'package:lazyclub/inner_screens/on_sale_screen.dart';
import 'package:lazyclub/inner_screens/product_details.dart';
import 'package:lazyclub/provider/cart_provider.dart';
import 'package:lazyclub/provider/dark_theme_provider.dart';
import 'package:lazyclub/provider/favor_provider.dart';
import 'package:lazyclub/provider/products_provider.dart';
import 'package:lazyclub/provider/viewed_provider.dart';
import 'package:lazyclub/screens/auth/forget_password.dart';
import 'package:lazyclub/screens/auth/login.dart';
import 'package:lazyclub/screens/auth/register.dart';
import 'package:lazyclub/screens/bottom_bar.dart';
import 'package:lazyclub/screens/orders/orders_screen.dart';
import 'package:lazyclub/screens/viewed_recently/viewed_recently.dart';
import 'package:lazyclub/screens/wishlist/wishlist_screen.dart';
import 'package:lazyclub/theme/mode.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    bool _isDark = false;
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('에러 발생!'),
                ),
              ),
            );
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(create: (context) => ProductsProvider()),
              ChangeNotifierProvider(create: (context) => CartProvider()),
              ChangeNotifierProvider(create: (context) => FavorProvider()),
              ChangeNotifierProvider(create: (context) => ViewedProvider()),
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                  theme: Styles.themeData(themeProvider.getDarkTheme, context),
                  debugShowCheckedModeBanner: false,
                  routes: {
                    OnSaleScreen.routeName: (context) => OnSaleScreen(),
                    EachCategoryScreen.routeName: (context) =>
                        EachCategoryScreen(),
                    FeedsScreen.routeName: (context) => FeedsScreen(),
                    ProductDetails.routeName: (context) => ProductDetails(),
                    WishlistScreen.routeName: (context) => WishlistScreen(),
                    OrderScreen.routeName: (context) => OrderScreen(),
                    ViewedScreen.routeName: (context) => ViewedScreen(),
                    LoginScreen.routeName: (context) => LoginScreen(),
                    RegisterScreen.routeName: (context) => RegisterScreen(),
                    ForgetPasswordScreen.routeName: (context) =>
                        ForgetPasswordScreen(),
                  },
                  home: LoginScreen());
            }),
          );
        });
  }
}
