import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import './product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<ProductProvider>(context);
    final loadedproducts = productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: loadedproducts.length,
      itemBuilder: (ctx,index) => ChangeNotifierProvider.value(
         value: loadedproducts[index],
          child: ProductItems(),
    ));
  }
}