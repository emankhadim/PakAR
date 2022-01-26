import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadProduct = Provider.of<ProductProvider>(
        context,listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(title: Text(loadProduct.title),),
    );
  }
}
