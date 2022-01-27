import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/main.dart';
import '../widgets/app_drawer.dart';
import '../providers/product_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/product_grid.dart';

class ProductScreens extends StatefulWidget {
  static const routeName = '/productscreen';
  @override
  _ProductScreensState createState() => _ProductScreensState();
}

class _ProductScreensState extends State<ProductScreens> {
  var _isInit = true;
  var _isLoading = false;
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductProvider>(context).fetchandsetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          isSeller!
              ? Container()
              : IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                  icon: Icon(Icons.shopping_cart)),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductGrid(),
      drawer: AppDrawer(),
    );
  }
}
