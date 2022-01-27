import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/main.dart';
import 'package:untitled/screens/orders_screen.dart';
import 'package:untitled/screens/products_screen.dart';
import 'package:untitled/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({Key? key}) : super(key: key);

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(userName!),
            automaticallyImplyLeading: false,
          ),
          isSeller! ? Container() : Divider(),
          isSeller!
              ? Container()
              : ListTile(
                  leading: Icon(Icons.shop),
                  title: Text('Shop'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(ProductScreens.routeName);
                  },
                ),
          isSeller! ? Container() : Divider(),
          isSeller!
              ? Container()
              : ListTile(
                  leading: Icon(Icons.payment),
                  title: Text('Orders'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(OrderScreens.routeName);
                  },
                ),
          isSeller! ? Divider() : Container(),
          isSeller!
              ? ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Manage products'),
                  onTap: () {
                    Navigator.of(context)
                        .pushReplacementNamed(UserProductsScreen.routeName);
                  },
                )
              : Container(),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () async {
              await auth.signOut();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
