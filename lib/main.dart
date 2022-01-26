import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/orders_providers.dart';
import 'package:untitled/screens/edit_screen.dart';
import 'package:untitled/screens/user_product_screen.dart';

import '../providers/cart_provider.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/product_detail_screen.dart';
import '../screens/products_screen.dart';
import './providers/product_provider.dart';

void main() {
  runApp(MyApp());
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
          title: 'Flutter Demo',
          theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.purpleAccent
        ),
        home: ProductScreens(),
          routes: {
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

