import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/product_provider.dart';
import 'package:untitled/screens/edit_screen.dart';

class UserProductItems extends StatelessWidget {
  final productid;
  final String title;
  final String img;

  const UserProductItems({Key? key,required this.title, required this.img, this.productid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(img),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(onPressed: (){Navigator.pushNamed(context,EditProductScreen.routeName,arguments: productid);}, icon: Icon(Icons.edit)),
            IconButton(onPressed: () async{
              try {
                await Provider.of<ProductProvider>(context, listen: false)
                    .deleteproduct(productid);
                scaffold.showSnackBar(SnackBar(content: Text('Deleting Product Successfully.')));
              }catch(error){
                scaffold.showSnackBar(SnackBar(content: Text('Deleting Failed')));
              }
            }, icon: Icon(Icons.delete)),

          ],
        ),
      ),
    );
  }
}
