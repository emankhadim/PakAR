import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/orders_providers.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text('My Cart'),),
      body: Column(
        children:[

          SizedBox(
                height: 500,
                width: double.infinity,
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx,index) {
                    return Dismissible(
                      key: ValueKey(cart.items.values.toList()[index].id),
                      confirmDismiss: (direction){
                        return showDialog(context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text('Are you sure ?'),
                          content: Text('Do you want to remove this item from the cart? '),
                          actions: [
                            TextButton(
                              onPressed:(){
                                Navigator.of(ctx).pop(true);
                              },
                              child: Text('Yes'),
                            ),
                            TextButton(
                              onPressed:(){
                                Navigator.of(ctx).pop(false);
                              },
                              child: Text('No'),
                            )
                          ],
                        ),
                        );

                      },
                      background: Container(
                        margin: EdgeInsets.all(8.0),
                        color: Theme.of(context).errorColor.withOpacity(0.5),
                        child: Icon(Icons.delete, color: Colors.white.withOpacity(0.6),size: 35,),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 10),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction){cart.removeItem(cart.items.keys.toList()[index]);},

                      child: Card(
                        child: ListTile(
                          leading: Image.network(cart.items.values.toList()[index].img),
                          title: Text('${cart.items.values.toList()[index].title}'),
                          trailing: Text(cart.items.values.toList()[index].price.toString()),
                        ),
                      ),
                    );
                  }
            ),
              ),
          SizedBox(height: 10,),
          Container(
            child: Text('${cart.totalAmount().toStringAsFixed(2)}'),
          ),
          SizedBox(height: 10,),
          orderButton(cart: cart)
          ],
        ),
      );
  }
}

class orderButton extends StatefulWidget {
  const orderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<orderButton> createState() => _orderButtonState();
}

class _orderButtonState extends State<orderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (widget.cart.totalAmount ==0 || _isLoading) ? null : () {
          setState(() {
            _isLoading= true;
          });
          Provider.of<Orders>(context,listen: false).addOrder(widget.cart.items.values.toList(), widget.cart.totalAmount());
          widget.cart.clear();
          setState(() {
            _isLoading= false;
          });
          },
        child: _isLoading ? CircularProgressIndicator() : Text("Order Now"));
  }
}
