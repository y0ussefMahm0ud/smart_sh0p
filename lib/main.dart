import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_sh0p/providers/cart_provider.dart';
import 'package:smart_sh0p/providers/order_provider.dart';
import 'package:smart_sh0p/providers/product_provider.dart';
import 'package:smart_sh0p/providers/theme_provider.dart';
import 'package:smart_sh0p/providers/user_provider.dart';
import 'package:smart_sh0p/providers/viewed_prod_provider.dart';
import 'package:smart_sh0p/providers/wishlist_provider.dart';
import 'package:smart_sh0p/screens/auth/forgot_password.dart';
import 'package:smart_sh0p/screens/auth/login.dart';
import 'package:smart_sh0p/screens/inner_screens/privacy%20&%20policy.dart';
import 'package:smart_sh0p/screens/inner_screens/support%20chat.dart';
import 'package:smart_sh0p/screens/search_screen.dart';
import 'consts/theme_data.dart';
import 'root_screen.dart';
import 'screens/auth/register.dart';
import 'screens/inner_screens/orders/orders_screen.dart';
import 'screens/inner_screens/product_details.dart';
import 'screens/inner_screens/viewed_recently.dart';
import 'screens/inner_screens/wishlist.dart';

void main()async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                  child: SelectableText(
                      "An error has been occured ${snapshot.error}"),
                ),
              );
            }
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => ThemeProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ProductProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => CartProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => WishlistProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => ViewedProdProvider(),
                ),
                ChangeNotifierProvider(
                  create: (_) => UserProvider(),
                ),
                 ChangeNotifierProvider(
                  create: (_) => OrdersProvider(),
                ),
              ],
              child: Consumer<ThemeProvider>(
                builder: (
                  context,
                  themeProvider,
                  child,
                ) {
                  
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: ' Smart_sh0p ',
                    theme: Styles.themeData(
                        isDarkTheme: themeProvider.getIsDarkTheme,
                        context: context),
                    home: const RootScreen(),
                    // home: const RegisterScreen(),
                    routes: {
                       
                      ProductDetails.routName: (context) =>
                          const ProductDetails(),
                      WishlistScreen.routName: (context) =>
                          const WishlistScreen(),
                      ViewedRecentlyScreen.routName: (context) =>
                          const ViewedRecentlyScreen(),
                      RegisterScreen.routName: (context) =>
                          const RegisterScreen(),
                      LoginScreen.routName: (context) => const LoginScreen(),
                      OrdersScreenFree.routeName: (context) =>
                          const OrdersScreenFree(),
                      ForgotPasswordScreen.routeName: (context) =>
                          const ForgotPasswordScreen(),
                      SearchScreen.routeName: (context) => const SearchScreen(),
                      RootScreen.routName: (context) => const RootScreen(),
                      Supportchat.routName: (context) =>
                          const Supportchat(),
                           Privacy.routName: (context) =>
                          const Privacy(),    
                      
                  
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
