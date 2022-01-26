import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/edit_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/product_provider.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
 static const routeName = '/userscreen';

 Future<void> _refreshproduct(BuildContext context) async {
   await Provider.of<ProductProvider>(context, listen: false).fetchandsetProduct();
 }


  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(onPressed:()=> Navigator.of(context).pushNamed(EditProductScreen.routeName), icon: const Icon(Icons.add)),
        ],
      ),
    drawer: AppDrawer(),
    body: RefreshIndicator(
      onRefresh: () => _refreshproduct(context),
      child: Padding(
      padding: EdgeInsets.all(8),
      child: ListView.builder(
      itemCount: productsData.items.length,
      itemBuilder: (_,index)=>
      Column(
        children: [
          UserProductItems(productid:productsData.items[index].id ,title: productsData.items[index].title, img: productsData.items[index].imageurl),
          Divider(),
        ],
      ),
      ),
      ),
    ),
    );
  }
}
