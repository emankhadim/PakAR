import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products.dart';
import '../providers/cart_provider.dart';
import '../screens/product_detail_screen.dart';

class ProductItems extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);
    final cart = Provider.of<Cart>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      child: GridTile(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context,ProductDetailScreen.routeName, arguments: products.id),
              child: Image.network(products.imageurl, fit: BoxFit.cover,)),
          footer: GridTileBar(
            backgroundColor: Colors.black.withOpacity(0.3),
            leading: Consumer<Products>(
              builder: (ctx,products,_) => IconButton(icon: Icon(products.isFavorite ? Icons.favorite : Icons.favorite_border_outlined),onPressed: () {
                products.isfavorite();
              }, color: Colors.green),
            ),
            trailing: IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){
              cart.addItem(products.id, products.title, products.price, products.imageurl);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Item added to Cart'),duration: Duration(seconds: 2),));
            },color: Colors.green ),
            title: Text(products.title,textAlign: TextAlign.center,style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),),
          ),
      ),
    );
  }
}
