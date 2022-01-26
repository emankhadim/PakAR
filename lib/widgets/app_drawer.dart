import 'package:flutter/material.dart';
import 'package:untitled/screens/orders_screen.dart';
import 'package:untitled/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: Text('hello'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap:() { Navigator.of(context).pushReplacementNamed('/');},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap:() { Navigator.of(context).pushReplacementNamed(OrderScreens.routeName);},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage products'),
            onTap:() { Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);},
          ),
        ],
      ),
    );
  }
}
