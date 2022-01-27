import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/orders_providers.dart';
import 'package:untitled/screens/Auth/login_page.dart';
import 'package:untitled/screens/Auth/signup_page.dart';
import 'package:untitled/screens/Auth/welcome_page.dart';
import 'package:untitled/screens/edit_screen.dart';
import 'package:untitled/screens/products_screen.dart';
import 'package:untitled/screens/user_product_screen.dart';
import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_detail_screen.dart';
import './providers/product_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.purpleAccent,
        ),
        home: WelcomePage(),
        routes: {
          WelcomePage.routeName: (ctx) => WelcomePage(),
          LoginPage.routeName: (ctx) => LoginPage(),
          SignUpPage.routeName: (ctx) => SignUpPage(),
          ProductScreens.routeName: (ctx) => ProductScreens(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreens.routeName: (ctx) => OrderScreens(),
          UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

bool? isSeller;
String? userName = "User Name";
